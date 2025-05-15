class_name FileManager
extends Node

const SAVE_PATH = "user://savegame.data"

func save() -> Dictionary:
	var save_dict = {
		"total_coin": Event.total_coin,
		"level_data": Event.level_data
	}
	return save_dict
	
func save_game() -> void:
	var save_file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	save_file.store_var(call("save"))
	
func load_game() -> void:
	if not FileAccess.file_exists(SAVE_PATH):
		save_game()
		return
	
	var save_file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	var saved_data = save_file.get_var()
	
	Event.total_coin = saved_data["total_coin"]
	Event.level_data = {} if saved_data["level_data"].is_empty() else saved_data["level_data"]
