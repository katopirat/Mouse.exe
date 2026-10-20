extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_dialog_window_window_closed() -> void:
	$"cutscene intro/Myš(stacionary)/AnimationPlayer".play("mys2")
	await $"cutscene intro/Myš(stacionary)/AnimationPlayer".animation_finished
	get_tree().change_scene_to_file("res://scenes/menu_2.tscn")
