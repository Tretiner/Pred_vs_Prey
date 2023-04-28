extends Node

var marginX := 10
var marginY := 10

var spriteSize := 32
var spriteScaleModifier := 1.2
var minSquareSize := 12.0

var secondsPerTick := 2.0

var maxBunnies := 20
var maxMolfs := 10
var maxFolfs := 10

var preyGrowDelay := 2
var preyReproduceDelay := 2

var predGrowDelay := 2
var predReproduceDelay := 2

var gridSize := Vector2i(20, 20)

var gameSeed: String :
	set(value):
		gameSeed = value
		seed(hash(gameSeed))


func set_seed(s: String = "") -> void:
	if s.is_empty():
		gameSeed = get_rand_str(6)
	else:
		gameSeed = s


func get_rand_str(length: int) -> String:
	if length == 0:
		return ""

	var s := ""
	for i in length:
		s += char(randi_range(48, 122))

	return s
