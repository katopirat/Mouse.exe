extends Area2D

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@export var next_scene: PackedScene

func level_completed():
	print(next_scene)
	if next_scene:
		print("b")
		get_tree().change_scene_to_packed(next_scene)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		print ("you are in finish")
		level_completed()
