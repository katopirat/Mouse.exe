extends Node2D

@export var next_animation: PackedScene

func _on_dialog_window_window_closed() -> void:
	$AnimationPlayer.play("fade_out")
	
	await $AnimationPlayer.animation_finished
	if get_tree():
		get_tree().change_scene_to_packed(next_animation)
	
