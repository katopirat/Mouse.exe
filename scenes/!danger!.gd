extends AnimatedSprite2D

@onready var camera_2d: Camera2D = $"../../cutscene intro/Node2D/AnimatedSprite2D/Camera2D"

var original_offset = Vector2.ZERO

func _ready():
	original_offset = camera_2d.offset

func _process(delta):
	var distance = global_position.distance_to(camera_2d.global_position)
	
	var shake = clamp((2000.0 - distance) / 8000.0, 0.0, 1.0) * 25.0
	
	camera_2d.offset = original_offset + Vector2(
		randf_range(-shake, shake),
		randf_range(-shake, shake)
	)
