extends Camera2D

var shake_strength = 0.0

func start_shake(strength: float, duration: float):
	shake_strength = strength
	await get_tree().create_timer(duration / 10.0).timeout
	shake_strength = 0.0

func _process(delta: float):
	if shake_strength > 0:
		offset = Vector2(
			randf_range(-shake_strength, shake_strength),
			randf_range(-shake_strength, shake_strength)
		)
	else:
		offset = Vector2.ZERO
