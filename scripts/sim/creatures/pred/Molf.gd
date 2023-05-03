class_name Molf
extends Pred


var foodToRepr = 5


func _init() -> void:
	speciesName = "molf"


func hunt() -> bool:
	if curGrowDelay != 0:
		return false

	var maxPoints := 0
	var target: Creature = null

	for newPos in possibleMoves:
		var creature = parentBoard.get_vect(newPos)

		if 	creature is Folf and \
			hp > foodToRepr + 1 and \
			creature.hp > foodToRepr + 1 and \
			self.is_ready_to_repr() and \
			creature.is_ready_to_repr():
			target = creature
			break

		if creature is Prey and creature.points > maxPoints:
			target = creature
			maxPoints = target.points

	if target is Prey:
		hp += target.kill("Killed by " + speciesName)
		parentBoard.swap(gridPos, target.gridPos)
		return true

	if target is Folf and hp >= 1.1 and target.hp >= 1.1:
		target.reproduce()
		target.hp -= foodToRepr
		hp -= foodToRepr

	return false


func _reproduce(newPos: Vector2i) -> void:
	var newSpecies = ["folf", "molf"].pick_random()
	_on_reproduce.emit(newPos, newSpecies)
