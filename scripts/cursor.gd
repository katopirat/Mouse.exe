extends CharacterBody2D


const SPEED = 100.0


func _physics_process(delta: float) -> void:
	var direction := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")

	velocity = direction * SPEED
	move_and_slide() 
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("click"):
		click(true)
		print("click")
		
	if Input.is_action_just_released("click"):
		click(false)

func click(pressed):
	print("click")
	var event = InputEventMouseButton.new()
	event.button_index = MOUSE_BUTTON_LEFT
	event.pressed = pressed
	event.position = get_global_transform_with_canvas().origin
	get_viewport().push_input(event, true)
