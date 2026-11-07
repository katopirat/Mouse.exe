extends Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if self_modulate == Color(0.4, 0.4, 0.4) :
		$CPUParticles2D.emitting = true
