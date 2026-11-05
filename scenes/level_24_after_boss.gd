extends Node2D
const cut_scene = "res://scenes/cut scene fall.tscn"

func _ready() -> void:
	if "ants" not in GameState.boss:
		GameState.boss.append("ants")
		get_tree().call_deferred("change_scene_to_file", cut_scene)
