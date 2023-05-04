class_name Pred
extends Creature


func _init():
	curLifeTicks = 24
	curGrowDelay = Global.predGrowDelay
	curReprDelay = Global.predReproduceDelay


func on_tick(tickCount: int) -> void:
	super(tickCount)
	if isDead: return

	if hp > 101:
		reproduce(true) # Критическая ситуация
		return

	if curGrowDelay == 0:
		if hunt():
			return

	hp -= 0.1
	if hp <= 0.01:
		kill("Умерло от голода")
		return

	move()


func hunt() -> bool:
	return false


