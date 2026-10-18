extends Area2D

@export var open_again: bool = false
@export var open_again_seconds: float = 8.0
@onready var shader_animation:AnimationPlayer = $"../../../../../CanvasLayer/AnimationTree"
@onready var click_ad_audio: AudioStreamPlayer = $AudioStreamPlayer
@onready var col_shape1: CollisionShape2D = $CollisionShape2D
@onready var col_shape2: CollisionShape2D = $CollisionShape2D2
var cursor_inside = false


func _ready() -> void:
	add_to_group("ads")
	
func _on_body_entered(body: Node2D) -> void:
	if body.name == "Cursor":
		cursor_inside = true

func _on_body_exited(body: Node2D) -> void:
	if body.name == "Cursor":
		cursor_inside = false

func _input(event):
	if cursor_inside and event.is_action_pressed("click") and Global.player_can_move and self == Global.highest_clickable_body:
		Global.player_can_move = false
		click_ad_audio.play()
		if shader_animation:
			shader_animation.play("glitch_close")
			
			await shader_animation.animation_finished
			print("ani f")
		if get_tree():
			get_tree().reload_current_scene()

func _on_x_button_ad_closed() -> void:
	if open_again:
		
		hide_ad_for_skibidi_seconnds()
	else:
		queue_free()

func hide_ad_for_skibidi_seconnds() -> void:
	if is_in_group("ads"):
		remove_from_group("ads")
	$AnimatedSprite2D.visible = false
	remove_child(col_shape1)
	remove_child(col_shape2)
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
	add_child(col_shape1)
	add_child(col_shape2)
	$AnimatedSprite2D.visible = true
	monitoring = true
	monitorable = true
	$XButtonAd.visible = true
	$XButtonAd.monitoring = true
	$XButtonAd.monitorable = true
	$Label.visible = false
	if not is_in_group("ads"):
		add_to_group("ads")
