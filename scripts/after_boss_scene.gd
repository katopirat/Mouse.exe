extends Node2D
@export var music = "chill"

func _ready() -> void:
	if Global.music_style != music:
		Global.music_style = music
	Global.player_can_move = false




func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	Global.player_can_move = true
