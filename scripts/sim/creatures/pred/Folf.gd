class_name Folf
extends Pred


func _init() -> void:
	speciesName = "folf"


func hunt() -> bool:
	if curGrowDelay != 0:
		return false

	var maxPoints := 0
	var target: Creature

	for newPos in possibleMoves:
		var creature = parentBoard.get_vect(newPos)
		if creature is Prey and creature.points > maxPoints:
			maxPoints = creature.points
			target = creature

	if target is Prey:
		hp += target.kill("Убит " + speciesName)
		parentBoard.swap(gridPos, target.gridPos)
		return true

	return false


func _reproduce(newPos: Vector2i) -> void:
	curReprDelay = Global.predReproduceDelay
	var newSpecies = ["folf", "molf"].pick_random()
	_on_reproduce.emit(newPos, newSpecies)
