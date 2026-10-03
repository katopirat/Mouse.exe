extends Node

var levels = [ 
	{"name": "Tutorial", "scene": "res://scenes/tutorial.tscn"},
	{"name": "The Button", "scene": "res://scenes/level_1.tscn"},
	{"name": "Ads", "scene": "res://scenes/level_2.tscn"},
	{"name": "Spaghetti", "scene": "res://scenes/level_3.tscn"},
	{"name": "ALT+TAB", "scene": "res://scenes/level_4.tscn"},
	{"name": "Another spaggety?!", "scene": "res://scenes/level_5.tscn"},
	{"name": "Clickbate ad", "scene": "res://scenes/level_6.tscn"},
	{"name": "Dino.exe", "scene": "res://scenes/level_7.tscn"},
	{"name": "Second button", "scene": "res://scenes/level_8.tscn"},
	{"name": "sensitivity", "scene": "res://scenes/level_9.tscn"},
	{"name": "magic table", "scene": "res://scenes/level_10.tscn"},
	{"name": "magic mice", "scene": "res://scenes/level_11.tscn"},
]

var unlocked = 1
var done = [] 
var best_times = {}

func _ready() -> void:
	for i in levels.size():
		best_times[i] = null
		
func go_to_level(i):
	var path = levels[i]["scene"]
	if ResourceLoader.exists(path):
		get_tree().call_deferred("change_scene_to_file", path)
		return true
	return false

func go_to_menu():
	get_tree().call_deferred("change_scene_to_file", "res://levels/level_00_menu.tscn")


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

func get_best_time(level):
	return best_times[level]
