extends PanelContainer

@export var text : String
@export var icon : Texture2D
@export var min_time : float = 0.02
@export var max_time : float = 0.025
@export var start : bool
@onready var label = $HBoxContainer/RichTextLabel
@export var click_to_close :bool
@export var animated : bool

signal window_closed

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
		started = true
	if click_to_close and started == true and Input.is_action_just_pressed("dialog"):
		$AudioStreamPlayer.stop()
		if animated:
			$AnimationPlayer.play_backwards("show_slow")
		else:
			$AnimationPlayer.play_backwards("show_fast")
		
		window_closed.emit()

func start_talk():
	
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
	for a in text :
		text_z += a
		label.text = text_z
		if a in waiting_time:
			$AudioStreamPlayer.stop()
			await get_tree().create_timer(waiting_time[a]).timeout
			$AudioStreamPlayer.play()
		else: 
			await get_tree().create_timer(randf_range(min_time,max_time)).timeout
		
	$AudioStreamPlayer.stop()
	
