class_name Prey
extends Creature


func on_tick(tickCount: int) -> void:
	super(tickCount)
	reproduce()
	move()


func _reproduce(newPos: Vector2i) -> void:
	_on_reproduce.emit(newPos, speciesName)
