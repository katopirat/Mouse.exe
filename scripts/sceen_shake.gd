extends Camera2D

@export var shake_intensity: float = 0.0
var shake_decay: float = 5.0

func _process(delta: float) -> void:
	if shake_intensity > 0:
		offset.x = randf_range(-shake_intensity, shake_intensity)
		offset.y = randf_range(-shake_intensity, shake_intensity)
		
		shake_intensity = move_toward(shake_intensity, 0.0, shake_decay * delta)
	else:
		offset = Vector2.ZERO

func start_shake(intensity: float, decay_speed: float = 15.0) -> void:
	shake_intensity = intensity
	shake_decay = decay_speed
