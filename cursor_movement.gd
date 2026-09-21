extends CharacterBody2D



@export var speed: float = 100.0


func _on_player_moved_mouse(dir: Variant) -> void:
	velocity = dir*speed
	move_and_slide()
