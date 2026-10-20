extends Node2D


func _on_dialog_window_window_closed() -> void:
	$AnimationPlayer.play("fade_out")
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_file("res://scenes/cut_scene_wakeup.tscn")
	
