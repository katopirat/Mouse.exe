extends AnimationPlayer

func _ready() -> void:
	await get_tree().create_timer(1.4).timeout
	play("fade_in")
	
	
	await get_tree().create_timer(1.6).timeout
	play_backwards("fade_in")
