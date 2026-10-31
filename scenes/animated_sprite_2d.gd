extends AnimatedSprite2D

@onready var player = get_parent()

func _process(delta: float) -> void:
	var current_speed = player.linear_velocity.length()
	speed_scale = max(current_speed / 100.0, 0.3)
	
