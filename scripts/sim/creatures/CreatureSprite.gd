class_name CreatureSprite
extends Node2D


@onready var sprite: Sprite2D


var squareSize := Global.minSquareSize
var spriteSize := Global.spriteSize
var scaleModifier := Global.spriteScaleModifier

var parentBoard: CreaturesBoard = null


func init(board: CreaturesBoard, row: int, column: int, sqrSize: float) -> void:
	sprite = $Sprite2D
	parentBoard = board
	gridPos = Vector2i(row, column)
	_on_board_resized(sqrSize)


var gridPos := Vector2i.ZERO:
	set(value):
		gridPos = value
		determine_grid_pos()

var isSelected := false :
	set(value):
		isSelected = value
		queue_redraw()


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
