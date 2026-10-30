extends Area2D
@onready var cursor_inside: bool = false
@onready var click_label: Label = $Control/ClickLabel
@onready var col_radius = $CollisionShape2D.shape.radius
signal cookie_clicked()
func _ready() -> void:
	add_to_group("clickable")
func _input(event):
	
	if event.is_action_pressed("click") and Global.player_can_move and self == Global.highest_clickable_body:
		cookie_clicked.emit()


func _on_cookie_clicker_click_label(power: float) -> void:
	var new_label = click_label.duplicate()
	add_child(new_label)

	new_label.visible = true
	new_label.text = "+" + str(power)

	var random_dir = Vector2.from_angle(randf_range(0.0, TAU))
	new_label.position += random_dir * (randf_range(0, col_radius * 0.9))

	var t = create_tween()
	t.set_parallel()

	t.tween_property(
		new_label,
		"position",
		new_label.position + Vector2(0, -50),
		0.5
	)

	t.tween_property(new_label, "modulate:a", 0.0, 0.5)

	await t.finished
	new_label.queue_free()
