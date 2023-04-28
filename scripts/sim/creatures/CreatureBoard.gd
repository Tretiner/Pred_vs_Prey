class_name CreatureBoard
extends Node


var board: Array # Array[Array[Creature]]


func init(rows: int, columns: int) -> void:
	board = []
	for r in rows:
		board.append([])
		for c in columns:
			board[r].append(null)


func in_bounds(xy: Vector2i):
	return  xy.x >= 0 and \
			xy.y >= 0 and \
			xy.x < board.size() and \
			xy.y < board[xy.x].size()


func swap(pos: Vector2i, newPos: Vector2i):
	var p1 = get_vect(pos)
	var p2 = get_vect(newPos)

	set_vect(newPos, p1)
	p1.gridPos = newPos

	set_vect(pos, p2)
	if p2 != null:
		p2.gridPos = pos


func is_not_occupied(xy: Vector2i) -> bool:
	return !is_occupied(xy)

func is_occupied(xy: Vector2i) -> bool:
	return is_occupied_xy(xy.x, xy.y)

func is_occupied_xy(x: int, y: int) -> bool:
	return board[x][y] != null


func set_vect(xy: Vector2i, creature: Creature) -> void:
	set_xy(xy.x, xy.y, creature)

func set_xy(x: int, y: int, creature: Creature) -> void:
	board[x][y] = creature


func get_vect(xy: Vector2i) -> Creature:
	return get_xy(xy.x, xy.y)

func get_xy(x: int, y: int) -> Creature:
	return board[x][y]
