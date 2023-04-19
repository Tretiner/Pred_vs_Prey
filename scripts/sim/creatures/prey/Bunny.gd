class_name Bunny
extends Prey


func _init():
	points = 0.5


func on_tick(tickCount: int) -> void:
	hp -= 0.1
	if hp <= 0.1:
		kill()
		return
	super(tickCount)


func _ready() -> void:
	speciesName = "bunny"


func _reproduce(newPos: Vector2i) -> void:
	if randi_range(1, 10) > 2:
		return
	super(newPos)
