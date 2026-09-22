extends Area2D
@onready var label : Label = $Label
var tween = Tween

func _ready() -> void:
	pass



func _process(delta: float) -> void:
	pass

func _on_body_entered(body: Node2D) -> void:
	print(body.get_groups())
	if body.is_in_group("player"):
		tween = create_tween()
		tween.tween_property(label, "modulate:a", 1.0, 0.5)
	
func _on_body_exited(body: Node2D) -> void:
	print(body.get_groups())
	if body.is_in_group("player"):
		tween = create_tween()
		tween.tween_property(label, "modulate:a", 0.0, 0.5)
