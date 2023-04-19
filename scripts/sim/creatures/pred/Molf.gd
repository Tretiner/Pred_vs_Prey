class_name Molf
extends Pred


var reprDelay = 2
var curDelay = reprDelay

var foodToStartRepr = 5


func _ready():
	speciesName = "molf"


func hunt() -> bool:
	var maxPoints := 0
	var target: Creature = null

	for newPos in possibleMoves:
		var creature = parentBoard.get_vect(newPos)

		if creature is Folf:
			target = creature
			if hp >= foodToStartRepr and target.hp >= foodToStartRepr:
				break

		if creature is Prey and creature.points > maxPoints:
			target = creature
			maxPoints = target.points

	if target is Prey:
			var preyCoords = target.gridPos
			hp += target.kill()
			parentBoard.swap(gridPos, preyCoords)
			return true
	if target is Folf:
			target.reproduce()
			target.hp -= 1
			hp -= 1
			return true

	return false
