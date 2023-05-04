class_name Prey
extends Creature


func _init():
	curLifeTicks = 24
	curGrowDelay = Global.preyGrowDelay
	curReprDelay = Global.preyReproduceDelay


func on_tick(tickCount: int) -> void:
	super(tickCount)
	if isDead: return

	curLifeTicks -= 1
	if curLifeTicks == 0:
		kill("Умерло из за старения")
		return

	if is_ready_to_repr():
		reproduce()
		curReprDelay = Global.preyReproduceDelay

	move()


func _reproduce(newPos: Vector2i) -> void:
	_on_reproduce.emit(newPos, speciesName)
