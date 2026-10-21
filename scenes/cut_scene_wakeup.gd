extends Node2D

@export var menu_scene: PackedScene
func _ready() -> void:
	$"cutscene intro/Node2D/CanvasLayer/AnimationTree".play("screen_open")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_dialog_window_window_closed() -> void:
	$"cutscene intro/Myš(stacionary)/AnimationPlayer".play("mys2")
	await $"cutscene intro/Myš(stacionary)/AnimationPlayer".animation_finished
	if get_tree():
		get_tree().change_scene_to_packed(menu_scene)
