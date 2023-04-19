class_name Pred
extends Creature


func on_tick(tickCount: int) -> void:
	hp -= 0.1
	if hp <= 0.1:
		kill()
		return

	super(tickCount)
	if hp > 100: # Critical situation
		reproduce(true)
	elif !hunt():
		move()

func hunt() -> bool:
	return false


