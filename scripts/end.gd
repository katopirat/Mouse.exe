extends Node2D

@export var nxt_scn: PackedScene
@export var finished: bool = false
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	Global.music_style = "ending"


func _process(delta: float) -> void:
	if finished:
		get_tree().change_scene_to_packed(nxt_scn)
