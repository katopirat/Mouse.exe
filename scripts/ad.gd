extends Area2D

@export var open_again: bool = false
@export var open_again_seconds: float = 8.0

var cursor_inside = false

func _ready() -> void:
	print("open_again")
func _on_body_entered(body: Node2D) -> void:
	if body.name == "Cursor":
		cursor_inside = true

func _on_body_exited(body: Node2D) -> void:
	if body.name == "Cursor":
		cursor_inside = false

func _input(event):
	if cursor_inside and event.is_action_pressed("click") and Global.player_can_move:
		get_tree().reload_current_scene()

func _on_x_button_ad_closed() -> void:
	if open_again:
		
		hide_ad_for_skibidi_seconnds()
	else:
		queue_free()

func hide_ad_for_skibidi_seconnds() -> void:
	$AnimatedSprite2D.visible = false
	monitoring = false
	monitorable = false
	$XButtonAd.visible = false
	$XButtonAd.monitoring = false
	$XButtonAd.monitorable = false
	cursor_inside = false
	$Label.visible = true
	$Timer.wait_time = open_again_seconds
	$Timer.start()


func _process(_delta: float) -> void:
	if not open_again:
		return
	$Label.text = str(ceil($Timer.time_left))


func _on_timer_timeout() -> void:
	$AnimatedSprite2D.visible = true
	monitoring = true
	monitorable = true
	$XButtonAd.visible = true
	$XButtonAd.monitoring = true
	$XButtonAd.monitorable = true
	$Label.visible = false
