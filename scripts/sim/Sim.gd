extends Node2D


signal _on_board_resized

signal _on_prey_tick
signal _on_pred_tick


@export var rows := Global.gridSize.y
@export var columns := Global.gridSize.x
@export var min_square_size := Global.minSquareSize
@export var backgroundColor := Color.hex(0x82A327)
@export var borderColor := Color.hex(0x555555)


@onready var target: Creature = null

@onready var squareSize := find_square_size()
@onready var borderSize := 1

@onready var creatures := CreatureBoard.new()

@onready var creaturesDict = {
	"bunny" : preload("res://scenes/dynamic/creatures/prey/Bunny.tscn"),
	"molf" : preload("res://scenes/dynamic/creatures/pred/Molf.tscn"),
	"folf" : preload("res://scenes/dynamic/creatures/pred/Folf.tscn"),
}


func _ready():
	DisplayServer.window_set_min_size(Vector2i(
		floor(120 + 120 + min_square_size * columns + Global.marginX * 2 * 2),
		floor(min_square_size * rows + Global.marginY * 2)
	))

	creatures.init(rows, columns)

	var creatureNames: Array[String] = []

	for i in randi_range(2, Global.maxBunnies): creatureNames.append("bunny")
	for i in randi_range(2, Global.maxMolfs): creatureNames.append("molf")
	for i in randi_range(2, Global.maxFolfs): creatureNames.append("folf")

	creatureNames.shuffle()

	for i in creatureNames.size():
		var randRow := randi_range(0, rows-1)
		var randColumn := randi_range(0, columns-1)

		if i >= rows * columns:
			print("No more space")
			break;

		while creatures.is_occupied_xy(randRow, randColumn):
			randRow = randi_range(0, rows-1)
			randColumn = randi_range(0, columns-1)

		add_creature_by_name(randRow, randColumn, creatureNames[i])

		print("%s at: (%d, %d)" % [creatureNames[i], randRow, randColumn])


func bind_signals_to_creature(creature: Creature) -> void:
	var type := "prey" if creature is Prey else "pred"

	creature._on_reproduce.connect(_on_creature_reproduce)
	creature._on_death.connect(_on_creature_death)

	connect("_on_board_resized", creature._on_board_resized)
	connect("_on_%s_tick" % type, creature.on_tick)


func add_creature_by_name(row: int, column: int, creatureName: String) -> void:
	var creature: Creature = creaturesDict[creatureName].instantiate()
	add_creature(row, column, creature)


func add_creature(row: int, column: int, creature: Creature) -> void:
	creature.init(creatures, row, column, squareSize)

	bind_signals_to_creature(creature)

	creatures.set_xy(row, column, creature)

	add_child(creature)


func find_square_size() -> float:
	var parentSize = get_parent().get_rect().size
	return maxf(
		minf(
			parentSize.x / columns,
			parentSize.y / rows
		),
		min_square_size
	)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_mouse_left"):
		on_left_mouse_click(event)

	elif event.is_action_pressed("ui_mouse_right"):
		on_right_mouse_click(event)


func on_left_mouse_click(_event: InputEvent) -> void:
	var mousePos = (get_viewport().get_mouse_position() - Vector2(10, 10)) - get_parent().get_rect().position

	if mousePos.x > 0 and mousePos.y > 0:
		var col = floor(mousePos.x / squareSize)
		var row = floor(mousePos.y / squareSize)

		if col < columns and row < rows:
			var creature = creatures.get_xy(col, row)
			print(mousePos, " ", squareSize, " ", creature)

			if creature == null: return

			if target != null:
				target.isSelected = false

			target = creature
			target.isSelected = true


func on_right_mouse_click(_event: InputEvent) -> void:
	if target != null:
		target.isSelected = false
		target = null


func _draw() -> void:
	print("draw")

	# Background
	draw_rect(
		Rect2(
			Vector2.ZERO,
			Vector2(columns * squareSize, rows * squareSize)
		),
		backgroundColor
	)

	# Vertical lines
	for r in range(1, rows):
		var rowOffset: float = r * squareSize
		draw_line(
			Vector2(0, rowOffset),
			Vector2(columns * squareSize, rowOffset),
			borderColor,
			borderSize
		)

	# Horizontal lines
	for c in range(1, columns):
		var columnOffset: float = c * squareSize
		draw_line(
			Vector2(columnOffset, 0),
			Vector2(columnOffset, rows * squareSize),
			borderColor,
			borderSize
		)


func _on_game_resized() -> void:
	squareSize = find_square_size()
	queue_redraw()
	_on_board_resized.emit(squareSize)


func _on_tick(tickCount: int, isPreyTurn: bool) -> void:
	if isPreyTurn:
		_on_prey_tick.emit(tickCount)
	else:
		_on_pred_tick.emit(tickCount)


func _on_creature_reproduce(newPos, speciesName):
	add_creature_by_name(newPos.x, newPos.y, speciesName)


func _on_creature_death(creature):
	creatures.set_vect(creature.gridPos, null)
