extends Node2D

@export var next_animation: PackedScene

func _on_dialog_window_window_closed() -> void:
	$Node2D/CanvasLayer/AnimationTree.play("close_screen")
	await $Node2D/CanvasLayer/AnimationTree.animation_finished
	if get_tree():
		get_tree().change_scene_to_packed(next_animation)
	
