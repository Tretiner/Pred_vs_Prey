class_name Bunny
extends Prey


func _init() -> void:
	speciesName = "bunny"
	points = 1


func _reproduce(newPos: Vector2i) -> void:
	if randi() % 10 < Global.bunReprChance:
		super(newPos)
