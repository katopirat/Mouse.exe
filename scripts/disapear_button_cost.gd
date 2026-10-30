extends Area2D
var cursor_inside = false
var is_pressed = false
var cost: int = 100
@onready var sound_player: AudioStreamPlayer = $AudioStreamPlayer
@onready  var p_money: float
signal close_obstacle()

func _ready() -> void:
	$AnimatedSprite2D.play('default')
	$Label.text = "$" + str(cost)
func _on_body_entered(body: Node2D) -> void:
	print(body.name)
	if body.name == "Cursor":
		cursor_inside = true
		
 
func _on_body_exited(body: Node2D) -> void:
	if body.name == "Cursor":
		cursor_inside = false
		

func _input(event):
	if event.is_action_pressed("click") and self == Global.highest_clickable_body and is_in_group("clickable"):
		print("a")
		if is_pressed:
			pass
		else:
			close_obstacle.emit()
			sound_player.play()
			$AnimatedSprite2D.play("pressed")
			is_pressed = true
			remove_from_group("clickable")
		
func _process(delta: float) -> void:
	if p_money < cost and is_in_group("clickable"):
		remove_from_group("clickable")
	elif p_money >= cost and not is_in_group("clickable"):
		add_to_group("clickable")

func _on_cookie_clicker_update_money(money: float) -> void:
	p_money = money
