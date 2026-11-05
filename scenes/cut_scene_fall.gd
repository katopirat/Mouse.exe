extends Node2D
var change_scene = false
@export var scene :PackedScene
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		change_scene = true
	get_tree().change_scene_to_packed(scene)
	
