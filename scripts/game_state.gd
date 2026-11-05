extends Node
@onready var menu: PackedScene = preload("res://scenes/menu_2.tscn")
var boss = []
var levels = [ 
	{"name": "Tutorial", "scene": "res://scenes/tutorial.tscn"},
	{"name": "The Button", "scene": "res://scenes/level_1.tscn"},
	{"name": "Ads", "scene": "res://scenes/level_2.tscn"},
	{"name": "Tutorial 2.0", "scene": "res://scenes/tutorial_how_to_move_cursor_but_not_mouse.tscn"},
	{"name": "Spaghetti", "scene": "res://scenes/level_3.tscn"},
	{"name": "ALT+TAB", "scene": "res://scenes/level_4.tscn"},
	{"name": "Dino.exe", "scene": "res://scenes/level_7.tscn"},
	{"name": "Second button", "scene": "res://scenes/level_8.tscn"},
	{"name": "Sensitivity too high", "scene": "res://scenes/level_9.tscn"},
	{"name": "Magic table", "scene": "res://scenes/level_10.tscn"},
	{"name": "Magic mice", "scene": "res://scenes/level_11.tscn"},
	{"name": "Cursor on the run", "scene": "res://scenes/level_13.tscn"},
	{"name": "The ads are getting real", "scene": "res://scenes/level_14.tscn"},
	{"name": "The button again?", "scene": "res://scenes/level_15.tscn"},
	{"name": "Glass on the table?", "scene": "res://scenes/level_16.tscn"},
	{"name": "E.M.O. The Boss", "scene": "res://scenes/level_17.tscn"},
	{"name": "Mice coin", "scene": "res://scenes/level_12.tscn"},
	{"name": "Who would buy this table?", "scene": "res://scenes/level_5.tscn"},
	{"name": "Micerix", "scene": "res://scenes/level_18.tscn"},
	{"name": "Buetooth OFF", "scene": "res://scenes/level_19.tscn"},
	{"name": "Chess?", "scene": "res://scenes/level_20.tscn"},
	{"name": "Out of Hand", "scene": "res://scenes/table_boss.tscn"},
	{"name": "Just ONE thousand ants", "scene": "res://scenes/level_24.tscn"},
	{"name": "Just ONE this time", "scene": "res://scenes/level_22.tscn"},
	{"name": "Biscuit clicker", "scene": "res://scenes/level_23.tscn"}
]

var unlocked = 1
var done = [] 
var best_times = {}
var game_pausable = true

func _ready() -> void:
	for i in levels.size():
		best_times[i] = null
	load_game()

func go_to_level(i):
	var path = levels[i]["scene"]
	if ResourceLoader.exists(path):
		get_tree().call_deferred("change_scene_to_file", path)
		return true
	return false

func go_to_menu():
	get_tree().call_deferred("change_scene_to_packed", menu)


func finish_level(final_time):
	var path = get_tree().current_scene.scene_file_path
	for i in levels.size():
		if levels[i]["scene"] == path:
			if not done.has(i):
				done.append(i)
			if unlocked < i + 2:
				unlocked = i + 2
			if best_times[i] == null or final_time < best_times[i]:
				best_times[i] = final_time
				print("new record "+str(best_times[i]))
	save_game()


func get_best_time(level):
	return best_times[level]
	
func save_game():
	var config = ConfigFile.new()
	config.set_value("data", "done", done)
	config.set_value("data", "achievements", AchievementState.completed)
	config.set_value("data", "best_times", best_times)
	config.set_value("data","unlocked",unlocked)
	var a = config.save("user://maus_goddots")
	if a == OK:
		print("game_saved")
	else:
		print("Something is wrong cannot save : ",a)

func load_game():
	
	var config = ConfigFile.new()
	var a = config.load("user://maus_goddots")
	print(config)
	if a == OK:
		print("game_loaded")
	else:
		print("no save : ",a)
		return
	done = config.get_value("data","done",[])
	unlocked = config.get_value("data", "unlocked", 1)
	AchievementState.completed = config.get_value("data","achievements",[])
	for key in config.get_value("data","best_times",{}):
		best_times[int(key)] =  config.get_value("data","best_times",{})[key]
	
