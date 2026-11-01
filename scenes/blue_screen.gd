extends Sprite2D
@onready var timer: Timer = $"../Timer"

	

func _ready() -> void:
	Global.music_style = "stop"
func _on_timer_timeout() -> void:
	Global.music_style = "dramatic"
	get_tree().change_scene_to_file("res://scenes/level_23.tscn")
