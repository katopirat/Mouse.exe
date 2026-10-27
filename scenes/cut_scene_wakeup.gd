extends Node2D

@export var menu_scene: PackedScene
func _ready() -> void:
	$"cutscene intro/Node2D/CanvasLayer/AnimationTree".play("screen_open")



func _on_dialog_window_window_closed() -> void:
	$"cutscene intro/Myš(stacionary)/AnimationPlayer".play("mys2")
	await $"cutscene intro/Myš(stacionary)/AnimationPlayer".animation_finished
	$"cutscene intro/Node2D/CanvasLayer/AnimationTree".play("close_screen")
	await $"cutscene intro/Node2D/CanvasLayer/AnimationTree".animation_finished
	if get_tree():
		get_tree().change_scene_to_packed(menu_scene)
