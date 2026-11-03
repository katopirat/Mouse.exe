extends Node2D

@onready var foot = $Foot
@onready var top_left = $TopLeft
@onready var bottom_right = $BottomRight

func _ready() -> void:
	remove_child(foot)
	dup(random_pos())
func random_pos():
	return Vector2(randf_range(top_left.global_position.x, bottom_right.global_position.x), randf_range(top_left.global_position.y, bottom_right.global_position.y))
func dup(position: Vector2):
	add_child(foot)
	foot.global_position = position
	await get_tree().create_timer(10).timeout
	dup(random_pos())
