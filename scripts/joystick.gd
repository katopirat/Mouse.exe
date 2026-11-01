extends Node2D


@onready var starting_pos: Vector2 = Vector2(9999, 9999)
@onready var min_change: float = 5.0
@onready var last_action = null
@onready var action = null
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			var click_pos = get_viewport().get_mouse_position()
			var screen_width = get_viewport().get_visible_rect().size.x
			if click_pos.x < (screen_width/2):
				starting_pos = click_pos
		else:
			starting_pos = Vector2(9999,9999)
func _process(delta: float) -> void:
	if starting_pos != Vector2(9999, 9999):
		var diff: Vector2 = starting_pos- get_viewport().get_mouse_position()
		if abs(diff.x) > min_change or abs(diff.y) > min_change:
			action = null
			if abs(diff.x) > abs(diff.y):
				if diff.x > 0:
					action = "left"
				else:
					action = "right"
			else:
				if diff.y > 0:
					action = "up"
				else:
					action = "down"
			if last_action != action:
	
				if last_action:
					var new_action = InputEventAction.new()
					new_action.action = last_action
					new_action.pressed = false
					Input.parse_input_event(new_action)
					last_action = null
					print(new_action)
				if action:
					var new_action = InputEventAction.new()
					new_action.action = action
					new_action.pressed = true
					Input.parse_input_event(new_action)
					print(new_action)
			last_action = action
	elif last_action:
		var new_action = InputEventAction.new()
		new_action.action = last_action
		new_action.pressed = false
		Input.parse_input_event(new_action)
		last_action = null
		print(new_action)
