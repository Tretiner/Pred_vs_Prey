class_name Molf
extends Pred


var foodToRepr = 5


func _init() -> void:
	speciesName = "molf"


func hunt() -> bool:
	var maxPoints := 0
	var target: Creature = null

	for newPos in possibleMoves:
		var creature = parentBoard.get_vect(newPos)

		if creature is Folf:
			target = creature
			if  hp > foodToRepr and \
				target.hp > foodToRepr and \
				curGrowDelay + curReprDelay == 0 and \
				target.curGrowDelay + target.curReprDelay == 0:
				break

		if creature is Prey and creature.points > maxPoints:
			target = creature
			maxPoints = target.points

	if target is Prey:
			var preyCoords = target.gridPos
			hp += target.kill("killed by " + speciesName)
			parentBoard.swap(gridPos, preyCoords)
			return true
	if target is Folf and hp >= 1.1 and target.hp >= 1.1:
			target.reproduce()
			target.hp -= 1
			hp -= 1
			return true

	return false


func _reproduce(newPos: Vector2i) -> void:
	var newSpecies = ["folf", "molf"].pick_random()
	_on_reproduce.emit(newPos, newSpecies)
