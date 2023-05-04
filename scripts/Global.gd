extends Node

var marginX := 10
var marginY := 10

var spriteSize := 32
var spriteScaleModifier := 1.2
var minSquareSize := 12.0

var secondsPerTick := 1.0

var bunReprChance := 1

var maxBunnies := 20
var maxMolfs := 6
var maxFolfs := 6

var minBunnies := 8
var minMolfs := 4
var minFolfs := 4

var preyGrowDelay := 2
var preyReproduceDelay := 2

var predGrowDelay := 4
var predReproduceDelay := 4

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
	var s := ""
	for i in length:
		s += char(randi_range(48, 122))
	return s


func sim_properties():
	return {
		"secondsPerTick" : secondsPerTick,
		"bunReprChance" : bunReprChance,
		"maxBunnies" : maxBunnies,
		"maxMolfs" : maxMolfs,
		"maxFolfs" : maxFolfs,
		"minBunnies" : minBunnies,
		"minMolfs" : maxMolfs,
		"minFolfs" : maxFolfs,
		"preyGrowDelay" : preyGrowDelay,
		"preyReproduceDelay" : preyReproduceDelay,
		"predGrowDelay" : predGrowDelay,
		"predReproduceDelay" : predReproduceDelay
	}

