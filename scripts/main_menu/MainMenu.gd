extends Container


const gridSizes: Array[Vector2i] = [
	Vector2i(10, 10),
	Vector2i(20, 20),
	Vector2i(30, 30),
	Vector2i(40, 40),
	Vector2i(50, 50)
]


@onready var optionsButton: OptionButton = $"VBoxContainer/VBoxContainer/SizeOptions"
@onready var seedEdit: LineEdit = $"VBoxContainer/VBoxContainer/SeedEdit"


func _on_play_pressed() -> void:
	set_global_greed_size()
	set_global_seed()

	get_tree().change_scene_to_file("res://scenes/static/Game.tscn")


func set_global_greed_size() -> void:
	Global.gridSize = gridSizes[optionsButton.selected]


func set_global_seed() -> void:
	if !seedEdit.text.is_empty():
		Global.gameSeed = seedEdit.text.strip_edges()
