class_name Creature
extends CreatureSprite


signal _on_reproduce(coords: Vector2, speciesName: String)
signal _on_death(creature: Creature)


var directions := _generate_directions(1)
var direction := Vector2i.ZERO

var possibleMoves: Array[Vector2i] = []

var curLifeTicks: int
var curGrowDelay: int
var curReprDelay: int

var speciesName: String = "creature"
var points := 1.0
var hp := 2.0

var isDead := false
var deathDesc: String


func get_stats_string() -> String:
	var stats = ""
	stats += "hp: %.1f\n" % hp
	stats += "points: %.1f" % points
	return stats


func on_tick(tickCount):
	if isDead: return

	if curGrowDelay > 0: curGrowDelay -= 1
	if curReprDelay > 0: curReprDelay -= 1

	observe()


func observe() -> void:
	directions.shuffle()
	possibleMoves = []

	for dir in directions:
		var newMove = gridPos + dir

		if parentBoard.not_in_bounds(newMove):
			continue

		possibleMoves.append(newMove)


func move() -> void:
	var freeMoves = possibleMoves.filter(func(move): return parentBoard.is_not_occupied(move))

	if freeMoves.size() == 0:
		return

	_move(freeMoves[0])


func _move(newPos: Vector2i) -> void:
	parentBoard.swap(gridPos, newPos)


func is_ready_to_repr() -> bool:
	return curGrowDelay + curReprDelay == 0


func reproduce(force: bool = false) -> void:
	for newPos in possibleMoves:
		if gridPos == newPos:
			continue

		var creature = parentBoard.get_vect(newPos)
		if force:
			if creature != null:
				creature.kill("Died due to bad luck")
			hp -= 100
			_reproduce(newPos)
			return

		if creature == null and hp > 1:
			_reproduce(newPos)
			return


func _reproduce(newPos: Vector2i) -> void:
	pass


func kill(_deathDesc: String) -> float:
	isDead = true
	deathDesc = _deathDesc
	_on_death.emit(self)
	queue_free()
	return points;


func _generate_directions(rng: int = 1) -> Array[Vector2i]:
	var dirs: Array[Vector2i] = []
	for x in range(-rng, rng+1):
		for y in range(-rng, rng+1):
			dirs.append(Vector2i(x, y))
	return dirs
