class_name Creature
extends Node2D


signal _on_reproduce(coords: Vector2, speciesName: String)
signal _on_death(creature: Creature)


var squareSize := Global.minSquareSize
var spriteSize := Global.spriteSize
var scaleModifier := Global.spriteScaleModifier

var parentBoard: CreatureBoard = null

var directions := _generate_directions(1)
var direction := Vector2i.ZERO

var possibleMoves: Array[Vector2i] = []

var isDead := false
var deathDesc: String


var gridPos := Vector2i.ZERO:
	set(value):
		gridPos = value
		determine_grid_pos()

var isSelected := false :
	set(value):
		isSelected = value
		queue_redraw()


var speciesName: String = "creature"
var points := 1.0
var hp := 2.0

var curLifeTicks: int = 12
var curGrowDelay: int
var curReprDelay: int


@onready var sprite: Sprite2D


func init(board, row, column, sqrSize) -> void:
	sprite = $Sprite2D
	parentBoard = board
	gridPos = Vector2i(row, column)
	_on_board_resized(sqrSize)


func _draw() -> void:
	if isSelected:
		draw_rect(
			Rect2(
				Vector2.ZERO,
				Vector2(squareSize, squareSize)
			),
			Color.DARK_ORANGE,
			false
		)


func get_stats_string() -> String:
	var stats = ""
	stats += "hp: %.1f\n" % hp
	stats += "points: %.1f" % points
	return stats


func on_tick(tickCount):
	if isDead: return

	if curGrowDelay > 0: curGrowDelay -= 1
	if curReprDelay > 0: curReprDelay -= 1

	observe()


func observe() -> void:
	directions.shuffle()
	possibleMoves = []

	for dir in directions:
		var newMove = gridPos + dir

		if !parentBoard.in_bounds(newMove):
			continue

		possibleMoves.append(newMove)


func move() -> void:
	for newPos in possibleMoves:
		if gridPos == newPos or parentBoard.is_occupied(newPos):
			break

		parentBoard.swap(gridPos, newPos)
		break


func reproduce(force: bool = false) -> void:
	for newPos in possibleMoves:
		if gridPos == newPos:
			continue

		var creature = parentBoard.get_vect(newPos)
		if force:
			if creature != null:
				creature.kill("was forced to die")
			hp -= 100
			_reproduce(newPos)
			return

		if creature == null and hp > 1:
			_reproduce(newPos)


func _reproduce(newPos: Vector2i) -> void:
	pass


func kill(_deathDesc: String) -> float:
	isDead = true
	deathDesc = _deathDesc
	_on_death.emit(self)
	queue_free()
	return points;


func _generate_directions(rng: int = 1) -> Array[Vector2i]:
	var dirs: Array[Vector2i] = []
	for x in range(-rng, rng+1):
		for y in range(-rng, rng+1):
			dirs.append(Vector2i(x, y))
	return dirs


func _on_board_resized(sqrSize) -> void:
	squareSize = sqrSize

	determine_grid_pos()
	determine_sprite_scale()
	center_sprite()


func determine_grid_pos() -> void:
	position = Vector2(
		gridPos.x * squareSize,
		gridPos.y * squareSize
	)

func determine_sprite_scale() -> void:
	var spriteScale = squareSize / spriteSize * scaleModifier
	sprite.scale = Vector2(spriteScale, spriteScale)


func center_sprite() -> void:
	sprite.position = Vector2(squareSize / 2, squareSize / 2)
