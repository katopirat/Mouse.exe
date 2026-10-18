extends Area2D
var pressed = false
signal start_dino_game()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(_on_body_entered) # Replace with function body.
	$Sprite2D.play("default")







func _on_body_entered(body: Node2D) -> void:
	$Sprite2D.play("pressed")
	if !pressed:
		start_dino_game.emit()
	pressed = true
