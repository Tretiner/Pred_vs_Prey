extends Node

var marginX := 10
var marginY := 10

var maxBunnies := 20
var maxMolfs := 10
var maxFolfs := 10

var spriteSize := 32
var spriteScaleModifier := 1.2
var minSquareSize := 12.0

var secondsPerTick := 2.0

var firstTurnPred := false

var gridSize := Vector2i(20, 20)

var gameSeed: String :
	set(value):
		gameSeed = value
		seed(hash(gameSeed))
