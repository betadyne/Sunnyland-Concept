extends Control

@onready var scene_tree = get_tree()
@onready var moneyLabel = $MoneyTexture/Label

func _ready():
	connect_level_selected_to_level_box()
	%FileManager.load_game()
	
	if Event.level_data.is_empty():
		Event.level_data = {1: false}
		setup_level_box()
	else:
		Event.level_data[1] = false
		
		for box in %LevelGrid.get_children():
			box.level_num = box.get_index() + 1
			if Event.level_data.has(box.level_num):
				box.locked = Event.level_data[box.level_num]
			else:
				box.locked = true
				
	moneyLabel.text = str(Event.total_coin)
	
func setup_level_box() -> void:
	for box in %TextureRect/LevelGrid.get_children():
			box.level_num = box.get_index() + 1
			box.locked = true
	%LevelGrid.get_child(0).locked = false

func change_to_scene(level_num: int) -> void:
	Event.curr_level = level_num
	$fader.fade_screen(true, 1.0, func(): scene_tree.change_scene_to_file("res://Levels/level_" + str(level_num) + ".tscn"))	
	
func connect_level_selected_to_level_box() -> void:
	for box in %TextureRect/LevelGrid.get_children(): box.connect("level_selected", change_to_scene)

func _on_home_button_down() -> void:
	scene_tree.change_scene_to_file("res://MainScreen/main_screen.tscn")
