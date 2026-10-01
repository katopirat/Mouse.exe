class_name OSInput
extends RefCounted
## Posílá pohyb a kliky virtuálního kurzoru do OS, který běží v SubViewportu.
## Díky tomu fungují normální Godot Buttony, CheckBoxy, hover i drag.

static func move(vp: SubViewport, pos: Vector2) -> void:
	var ev := InputEventMouseMotion.new()
	ev.position = pos
	ev.global_position = pos
	vp.push_input(ev, true)

static func button(vp: SubViewport, pos: Vector2, pressed: bool, index := MOUSE_BUTTON_LEFT, double := false) -> void:
	var ev := InputEventMouseButton.new()
	ev.button_index = index
	ev.pressed = pressed
	ev.double_click = double
	ev.position = pos
	ev.global_position = pos
	ev.button_mask = (MOUSE_BUTTON_MASK_LEFT if index == MOUSE_BUTTON_LEFT else MOUSE_BUTTON_MASK_RIGHT) if pressed else 0
	vp.push_input(ev, true)
