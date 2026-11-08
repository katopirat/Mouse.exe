extends Node2D

@export var nxt_scn: PackedScene
@export var finished: bool = false
func _ready() -> void:
	Global.music_style = "ending"


func _process(delta: float) -> void:
	if finished:
		get_tree().change_scene_to_packed(nxt_scn)
