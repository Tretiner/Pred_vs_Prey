extends VBoxContainer


@onready var lblName: Label = $"Name"
@onready var lblStats: Label = $"Stats"


func _on_sim__on_target_update(target: Creature) -> void:
	visible = target != null

	if !visible:
		return

	if target.isDead:
		lblName.text = '✞ '+ target.speciesName
		lblStats.text = target.deathDesc
	else:
		lblName.text = target.speciesName
		lblStats.text = target.get_stats_string()
