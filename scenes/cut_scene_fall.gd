extends Node2D
var change_scene = false
@export var scene :PackedScene
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	wait()
	

func wait()
	while change_scene == false:
		pass
	get_tree().change_scene_to_packed(scene)
	
