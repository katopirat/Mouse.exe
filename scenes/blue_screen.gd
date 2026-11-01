extends Node2D
@onready var timer: Timer = $"../Timer"

@onready var ready_to_pass = false

func _ready() -> void:
	Global.music_style = "stop"
	await $AudioStreamPlayer.finished
	ready_to_pass = true
	$Achievements.completed_achievement("To Jsou Ty Windousy")
func _on_timer_timeout() -> void:
	Global.music_style = "dramatic"
	get_tree().change_scene_to_file("res://scenes/level_23.tscn")
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("click") and ready_to_pass:
		get_tree().change_scene_to_file("res://scenes/level_23.tscn")
