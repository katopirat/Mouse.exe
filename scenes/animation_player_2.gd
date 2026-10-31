extends AnimationPlayer
@onready var timer: Timer = $Timer

func _input(event: InputEvent) -> void:

	
	
		if event is InputEventMouseButton:
			if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:


				play("new_animation")
