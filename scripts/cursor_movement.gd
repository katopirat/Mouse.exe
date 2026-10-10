extends CharacterBody2D

@export var speed: float = 20.0

func _ready() -> void:
	if has_node("Arrow"):
		$Arrow.visible = true
	if has_node("Hand"):
		$Hand.visible = false

func _on_player_moved_mouse(dir: Variant) -> void:
	velocity = dir * speed
	move_and_slide()

func set_click_mode(mode) -> void:
	var a = mode == "arrow"
	if has_node("Arrow") and has_node("Hand"):
		$Arrow.visible = a
		$Hand.visible = !a
