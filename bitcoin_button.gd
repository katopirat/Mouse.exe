extends Area2D
var cursor_inside = false
var is_pressed = false
@export_enum("Buy", "Sell") var button_type: String
@onready var sound_player:AudioStreamPlayer = $AudioStreamPlayer
signal sell_bitcoin()
signal buy_bitcoin()
func _on_body_entered(body: Node2D) -> void:
	print(body.name)
	if body.name == "Cursor":
		cursor_inside = true
 
func _on_body_exited(body: Node2D) -> void:
	if body.name == "Cursor":
		cursor_inside = false

func _input(event):
	
	if cursor_inside and event.is_action_pressed("click"):
		print("a")
		if is_pressed:
			pass
		else:
			if button_type == "Buy":
				buy_bitcoin.emit()
			elif button_type == "Sell":
				sell_bitcoin.emit()
			sound_player.play()
			$AnimatedSprite2D.play("pressed")
			is_pressed = true
	elif is_pressed:
		is_pressed = false
		$AnimatedSprite2D.play("default")
