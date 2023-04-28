class_name Pred
extends Creature


func _init():
	curGrowDelay = Global.predGrowDelay
	curReprDelay = Global.predReproduceDelay


func on_tick(tickCount: int) -> void:
	hp -= 0.1
	if hp <= 0.01:
		kill("died of starving")
		return

	super(tickCount)

	if hp > 100 and curGrowDelay + curReprDelay == 0:
		reproduce(true) # Critical situation


	elif !hunt():
		move()

func hunt() -> bool:
	return false


