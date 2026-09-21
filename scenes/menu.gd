extends Node2D


func _ready() -> void:
	pass 


func _process(delta: float) -> void:
	pass


func _on_play_pressed() -> void:
	print("start")
	get_tree().change_scene_to_file("res://scenes/tutorial.tscn")
