extends Node2D

@export var nxt_scn: PackedScene
func _ready() -> void:
	Global.music_style = "ending"





func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	await get_tree().create_timer(5).timeout
	get_tree().change_scene_to_packed(nxt_scn)
	
