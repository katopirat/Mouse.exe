extends Area2D

@export var open_again: bool = false
@export var open_again_seconds: float = 8.0
@onready var shader_animation:AnimationPlayer = $"../../../../CanvasLayer/AnimationTree"
@onready var click_ad_audio: AudioStreamPlayer = $AudioStreamPlayer
@onready var buy_ad_audio: AudioStreamPlayer = $AudioStreamPlayer2
@onready var finish: Area2D = $"../../../../Finish"
@onready var money_have: float = 0
@onready var mousepad_cost: float = 2000.0
signal ad_bought(price: float)
var cursor_inside = false

func _ready() -> void:
	$"../../../..".remove_child.call_deferred(finish)
	print("open_again")
	
func _on_body_entered(body: Node2D) -> void:
	if body.name == "Cursor":
		cursor_inside = true
		if body.has_method("set_click_mode"):
			body.set_click_mode("hand")

func _on_body_exited(body: Node2D) -> void:
	if body.name == "Cursor":
		cursor_inside = false
		if body.has_method("set_click_mode"):
			body.set_click_mode("arrow")
func _input(event):
	if cursor_inside and event.is_action_pressed("click") and Global.player_can_move:
		if money_have >= mousepad_cost:
			buy_ad_audio.play()
			ad_bought.emit(mousepad_cost)
			$"../../../..".add_child(finish)
			$"../../../../Table/TileMapDotted".visible = false
			$".".queue_free()
		else:
			click_ad_audio.play()
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


func _on_graph_money_to_spend(money: float) -> void:
	money_have = money
