class_name Pred
extends Creature


func _init():
	curGrowDelay = Global.predGrowDelay
	curReprDelay = Global.predReproduceDelay


func on_tick(tickCount: int) -> void:
	super(tickCount)
	if isDead: return

	if hp > 101 and curGrowDelay + curReprDelay == 0:
		reproduce(true) # Critical situation
		return

	if hunt():
		return

	hp -= 0.1
	if hp <= 0.01:
		kill("Starved to death")
		return

	move()


func hunt() -> bool:
	return false


