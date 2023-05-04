extends Control


signal on_tick(tickCount: int, isPreyTurn: bool)
signal on_refresh_results()


var ticks := 0.0
var curSecPerTick: float = Global.secondsPerTick
var curTurn := 0

var _secondsLeft := curSecPerTick
var _secondsModidfier := 1.0

var _gameStopped := false
var _turnsEnabled := true


var popups: Dictionary = {}


@onready var seedLabel: Label = $"UI/Left/SeedLabel"
@onready var tickLabel: Label = $"UI/Left/TickPanel/TickLabel"
@onready var speedSlider: TextSlider = $"UI/Left/SpeedSlider"

@onready var turn1Btn: TextureButton = $"UI/Left/TurnPanel/Turn1"
@onready var turn2Btn: TextureButton = $"UI/Left/TurnPanel/Turn2"


func _ready():
	set_speed(_secondsModidfier)
	seedLabel.text = "RANDOM" if Global.gameSeed.is_empty() else Global.gameSeed


func set_speed(secModifier: float) -> void:
	reset_tick_timer(secModifier)
	speedSlider.text = "< Spd: %.1f >" % secModifier


func reset_tick_timer(newSecondsModifier: float) -> void:
	_secondsModidfier = newSecondsModifier
	curSecPerTick = Global.secondsPerTick / _secondsModidfier
	_secondsLeft = curSecPerTick


func _draw():
	for popup in popups:
		if popups[popup] != null and popups[popup].visible:
			(popups[popup] as PopupPanel).popup_centered()


func _process(delta) -> void:
	if _gameStopped: return

	_secondsLeft -= delta
	if _secondsLeft > 0.0: return

	ticks += 0.5
	_secondsLeft += curSecPerTick

	var isPreyTurn = int(ticks) == ticks
	_tick(floor(ticks), isPreyTurn)


func _tick(tickCount: int, isPreyTurn: bool) -> void:
	if not isPreyTurn:
		tickLabel.text = "Tick: %d" % ticks

	_set_turn(isPreyTurn)
	on_tick.emit(ticks, isPreyTurn)


func _set_turn(isPreyTurn: bool) -> void:
	turn1Btn.disabled = _turnsEnabled and !isPreyTurn
	turn2Btn.disabled = _turnsEnabled and isPreyTurn


func _on_start_stop_toggled(stopped: bool) -> void:
	_gameStopped = stopped


func _on_skip_next_pressed():
	ticks += 0.5
	_secondsLeft = curSecPerTick
	_tick(ticks, int(ticks) == ticks)


func _on_speed_slider_on_drag_end(value_changed: bool) -> void:
	if !value_changed:
		return

	_turnsEnabled = speedSlider.value < 30
	set_speed(speedSlider.value)


func _on_graph_pressed():
	_show_popup_by_name("SimResults")


func _on_settings_pressed():
	_show_popup_by_name("Settings")


func _on_back_pressed():
	get_tree().change_scene_to_file("res://scenes/static/MainMenu.tscn")


func _on_restart_pressed():
	Global.set_seed()
	get_tree().reload_current_scene()


func _show_popup_by_name(popupName: String):
	if popupName not in popups:
		print("res://scenes/static/popups/%s.tscn" % popupName)
		popups[popupName] = load("res://scenes/static/popups/%s.tscn" % popupName).instantiate()
		add_child(popups[popupName])
	popups[popupName].show()
