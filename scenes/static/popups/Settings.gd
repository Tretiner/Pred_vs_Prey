extends PopupPanel


@onready var spin_secondsPerTick = $"Margin/Options/Global/SecondsPerTick/Spin"


@onready var spin_bunMin = $"Margin/Options/Bunnies/Min/Spin"
@onready var spin_bunMax = $"Margin/Options/Bunnies/Max/Spin"
@onready var spin_bunReprChance = $"Margin/Options/Bunnies/ReprChance/Spin"
@onready var spin_preyReprDelay = $"Margin/Options/Bunnies/ReprDelay/Spin"

@onready var spin_predGrowDelay = $"Margin/Options/Pred/GrowDelay/Spin"
@onready var spin_predReprDelay = $"Margin/Options/Pred/ReprDelay/Spin"

@onready var spin_molfMin = $"Margin/Options/Molf/Min/Spin"
@onready var spin_molfMax = $"Margin/Options/Molf/Max/Spin"

@onready var spin_folfMin = $"Margin/Options/Folf/Min/Spin"
@onready var spin_folfMax = $"Margin/Options/Folf/Max/Spin"


# Called when the node enters the scene tree for the first time.
func _ready():
	spin_secondsPerTick.value = Global.secondsPerTick

	spin_bunMin.value = Global.minBunnies
	spin_bunMax.value = Global.maxBunnies
	spin_bunReprChance.value = Global.bunReprChance
	spin_preyReprDelay.value = Global.preyReproduceDelay

	spin_predGrowDelay.value = Global.predGrowDelay
	spin_predReprDelay.value = Global.predReproduceDelay

	spin_molfMin.value = Global.minMolfs
	spin_molfMax.value = Global.maxMolfs

	spin_folfMin.value = Global.minFolfs
	spin_folfMax.value = Global.maxFolfs

	popup_centered()


func _on_secPerTick_changed(value):
	Global.secondsPerTick = value


func _on_bunnyMin_changed(value):
	Global.minBunnies = Global.maxBunnies - 1 if value >= Global.maxBunnies else value


func _on_bunnyMax_changed(value):
	Global.maxBunnies = value


func _on_reprChance_changed(value):
	Global.bunReprChance = value


func _on_reprDelay_changed(value):
	Global.preyReproduceDelay = value


func _on_predGrowDelay_changed(value):
	Global.predGrowDelay = value


func _on_predReprDelay_changed(value):
	Global.predReproduceDelay = value


func _on_molfMin_changed(value):
	Global.minMolfs = Global.maxMolfs - 1 if value >= Global.maxMolfs else value


func _on_molfMax_changed(value):
	Global.maxMolfs = value


func _on_folfMin_changed(value):
	Global.minFolfs = Global.maxFolfs - 1 if value >= Global.maxFolfs else value


func _on_folfMax_changed(value):
	Global.maxFolfs = value
