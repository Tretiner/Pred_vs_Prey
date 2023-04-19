extends Control


signal on_tick(tickCount: int, isPreyTurn: bool)


var ticks := 0

var curSecPerTick: float = Global.secondsPerTick
var secondsLeft := curSecPerTick
var secondsModidfier := 1.0
var curTurn := 0

var gameStopped := false
var _disableTurnsSwitch := false

@onready var seedLabel = $"UI/Left/SeedLabel"
@onready var tickLabel = $"UI/Left/TickPanel/TickLabel"
@onready var speedSlider = $"UI/Left/SpeedSlider"

@onready var turn1Btn: TextureButton = $"UI/Left/TurnPanel/Turn1"
@onready var turn2Btn: TextureButton = $"UI/Left/TurnPanel/Turn2"


func _ready():
	set_speed(secondsModidfier)
	seedLabel.text = "RANDOM" if Global.gameSeed.is_empty() else Global.gameSeed
	tickLabel.text = "Tick %d" % ticks


func set_speed(secModifier: float) -> void:
	reset_tick_timer(secModifier)
	speedSlider.text = "< Spd: %.1f >" % secModifier


func reset_tick_timer(newSecondsModifier: float) -> void:
	secondsModidfier = newSecondsModifier
	curSecPerTick = Global.secondsPerTick / secondsModidfier
	secondsLeft = curSecPerTick


func _process(delta) -> void:
	if gameStopped: return

	secondsLeft -= delta

	if secondsLeft > 0.0: return

	ticks += 1
	secondsLeft += curSecPerTick

	_tick(ticks, ticks & 1)


func _tick(tickCount: int, isPreyTurn: bool) -> void:
	tickLabel.text = "Tick: %d" % ticks
	print("\n-- Tick: %d --" % ticks)

	_set_turn(isPreyTurn)
	on_tick.emit(ticks, isPreyTurn)


func _set_turn(isPreyTurn: bool) -> void:
	if _disableTurnsSwitch:
		turn1Btn.disabled = false
		turn2Btn.disabled = false
		return

	turn1Btn.disabled = !isPreyTurn
	turn2Btn.disabled = isPreyTurn


func _on_start_stop_toggled(stopped: bool) -> void:
	gameStopped = stopped


func _on_skip_next_pressed():
	ticks += 1
	secondsLeft = curSecPerTick
	_tick(ticks, 0)


func _on_speed_slider_on_drag_end(value_changed: bool) -> void:
	if !value_changed: return
	_disableTurnsSwitch = speedSlider.value > 30
	set_speed(speedSlider.value)


func _on_button_pressed():
	get_tree().change_scene_to_file("res://scenes/static/Game.tscn")
