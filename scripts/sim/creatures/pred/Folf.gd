class_name Folf
extends Pred


func _init() -> void:
	speciesName = "folf"


func hunt() -> bool:
	var maxPoints := 0
	var target: Creature

	for newPos in possibleMoves:
		var c = parentBoard.get_vect(newPos)
		if c is Prey and c.points > maxPoints:
			maxPoints = c.points
			target = c

	if target is Prey:
		var preyCoords = target.gridPos
		hp += target.kill("killed by " + speciesName)
		parentBoard.swap(gridPos, preyCoords)
		return true

	return false


func _reproduce(newPos: Vector2i) -> void:
	var newSpecies = ["folf", "molf"][randi_range(0, 1)]
	_on_reproduce.emit(newPos, newSpecies)
