class_name Bunny
extends Prey


func _init() -> void:
	points = 0.5
	speciesName = "bunny"


func on_tick(tickCount: int) -> void:
	super(tickCount)


func _reproduce(newPos: Vector2i) -> void:
	if randi_range(1, 10) > 2:
		return
	super(newPos)
