extends CharacterBody2D

@export var speed = 20.0

var last_pos = Vector2(-9999, -9999)


func _on_player_moved_mouse(dir):
	velocity = dir * speed
	move_and_slide()


func _physics_process(delta):
	if position != last_pos:
		var event = InputEventMouseMotion.new()
		event.position = get_global_transform_with_canvas().origin
		get_viewport().push_input(event, true)
		last_pos = position

	if Input.is_action_just_pressed("click"):
		click(true)
	if Input.is_action_just_released("click"):
		click(false)


func click(pressed):
	var event = InputEventMouseButton.new()
	event.button_index = MOUSE_BUTTON_LEFT
	event.pressed = pressed
	event.position = get_global_transform_with_canvas().origin
	get_viewport().push_input(event, true)
