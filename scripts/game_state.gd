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
	{"name": "No name idk plssssssssssssssssssssssssssss", "scene": "res://scenes/level_8.tscn"},
	{"name": "sensitivity", "scene": "res://scenes/level_9.tscn"},
	{"name": "No name idk plssssssssssssssssssssssssssss", "scene": "res://scenes/level_10.tscn"},
	{"name": "magic mice", "scene": "res://scenes/level_11.tscn"},
]

var unlocked = 1


func go_to_level(i):
	var path = levels[i]["scene"]
	if ResourceLoader.exists(path):
		get_tree().call_deferred("change_scene_to_file", path)
		return true
	return false


func go_to_menu():
	get_tree().call_deferred("change_scene_to_file", "res://levels/level_00_menu.tscn")


func finish_level():
	var path = get_tree().current_scene.scene_file_path
	for i in levels.size():
		if levels[i]["scene"] == path:
			if unlocked < i + 2:
				unlocked = i + 2
