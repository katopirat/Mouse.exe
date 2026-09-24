extends Node2D


func _ready() -> void:
	pass 


func _process(delta: float) -> void:
	pass


func _on_play_pressed() -> void:
	print("start")
	get_tree().change_scene_to_file("res://scenes/menu_levels.tscn")


func _on_tut_button_2_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/tutorial.tscn")


func _on_button_pressed() -> void:
	pass # Replace with function body.
