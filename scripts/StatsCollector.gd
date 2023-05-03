extends Node


signal on_tick_end


var maxY := 0

var currentTick := 0
var statsDict: Dictionary = {}
# 9 : {
#	"bunny": 0,
#	"molf": 1,
#	"folf": 2
#}


func reset(_buns: int, _molfs: int, _folfs: int) -> void:
	maxY = 0
	currentTick = 0
	statsDict.clear()
	statsDict[currentTick] = {
		"bunny": _buns,
		"molf": _molfs,
		"folf": _folfs
	}


func report_new_tick() -> void:
	currentTick += 1
	statsDict[currentTick] = statsDict[currentTick-1].duplicate()
	on_tick_end.emit()


func report_creature_reproduce(species_name: String) -> void:
	statsDict[currentTick][species_name] += 1


func report_creature_death(species_name: String) -> void:
	statsDict[currentTick][species_name] -= 1


func get_tick_stats(tickNum: int) -> Dictionary:
	return statsDict[tickNum]
