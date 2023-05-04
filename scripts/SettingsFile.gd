class_name SettingsFile
extends Node


static func saveSettings():
	var save_game = FileAccess.open("user://settings.save", FileAccess.WRITE)

	var json = JSON.stringify(Global.sim_properties())

	save_game.store_line(json)
	save_game.close()


static func loadSettings():
	if not FileAccess.file_exists("user://settings.save"):
		print("File doesnt exist")
		return

	var save_game = FileAccess.open("user://settings.save", FileAccess.READ)

	var json = JSON.new()
	var parse_res = json.parse(save_game.get_line())

	if parse_res != OK:
		print("Failed to parse")
		return

	var data = json.get_data()

	for key in data:
		print("%s = %d" % [key, data[key]])
		Global.set(key, data[key])
