extends PanelContainer
@export var time_before_start:float =0
@export var text : String
@export var icon : Texture2D
@export var min_time : float = 0.02
@export var max_time : float = 0.025
@export var start : bool
@onready var label = $HBoxContainer/RichTextLabel
@export var click_to_close :bool
@export var animated : bool
var closed = false
signal window_closed
@onready var skip_animation = false
@export var wait_time: float
var is_typing: bool = false
var text_finished: bool = false

@onready var waiting_time: Dictionary = {
	",": 0.5,
	".": 0.7,
	"!": 0.7,
	"?": 0.7
}


func _ready() -> void:
	visible = false
	
	$HBoxContainer/Icon.texture = icon
	
var started = false
func _process(delta: float) -> void:
	if start :
		start_talk()
		start = false
	
		
	if Input.is_action_just_pressed("dialog") and !closed:
		if is_typing:
			skip_animation = true
		elif text_finished and click_to_close:
			closed = true
			$AudioStreamPlayer.stop()
			if animated:
				$AnimationPlayer.play_backwards("show_slow")
			else:
				$AnimationPlayer.play_backwards("show_fast")
			
			window_closed.emit()

	

func start_talk():
	$HBoxContainer/Icon.texture = icon  
	closed = false
	skip_animation = false
	text_finished = false
	is_typing = false
	await get_tree().create_timer(time_before_start).timeout
	label.text = ""
	modulate = Color(1.0, 1.0, 1.0, 0.0)
	visible = true
	
	if animated:
		$AnimationPlayer.play("show_slow")
	else:
		$AnimationPlayer.play()
	
	await $AnimationPlayer.animation_finished
	
	var text_z :String
	$AudioStreamPlayer.play()
	is_typing = true
	for a in text:
		if closed:
			$AudioStreamPlayer.stop()
			return
		if skip_animation:
			label.text =text
			break
		text_z += a
		label.text = text_z
		if a in waiting_time:
			
			$AudioStreamPlayer.stop()
			await get_tree().create_timer(waiting_time[a]).timeout
			if !skip_animation:
				$AudioStreamPlayer.play()
		else: 
			await get_tree().create_timer(randf_range(min_time,max_time)).timeout
	is_typing = false
	text_finished = true
	$AudioStreamPlayer.stop()
	if wait_time:
		await get_tree().create_timer(wait_time).timeout
		skip_animation = true
		
	
