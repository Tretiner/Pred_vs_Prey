class_name Bunny
extends Prey


func _init() -> void:
	points = 1
	speciesName = "bunny"


func on_tick(tickCount: int) -> void:
	super(tickCount)


func _reproduce(newPos: Vector2i) -> void:
	if randi() % 10 < 2:
		super(newPos)
