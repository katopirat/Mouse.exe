extends Area2D
@onready var cursor_inside = false
@onready var pressed: bool = false
@onready var viewport = $"../../SubViewportContainer/SubViewport"
@export_enum("button_right", "button_left", "button_up", "button_down") var control_event: String


func _on_body_entered(body: Node2D) -> void:
	print(body.name)
	if body.name == "Cursor":
		cursor_inside = true
		
 
func _on_body_exited(body: Node2D) -> void:
	if body.name == "Cursor":
		cursor_inside = false
		
func _process(delta: float) -> void:
	if cursor_inside and Input.is_action_pressed("click") and Global.player_can_move:
		if not pressed:
			pressed = true
			push_move_action(pressed)
	elif pressed:
		pressed = false
		push_move_action(pressed)
func push_move_action(is_pressed):
	var event = InputEventAction.new()
	event.action = control_event
	event.pressed = is_pressed
	viewport.push_input(event)
