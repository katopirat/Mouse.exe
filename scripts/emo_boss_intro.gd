extends Control
@export var shake = 0
@export var next : PackedScene
@onready var shader_animation = $Shader_visuals/AnimationTree
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$CanvasLayer.visible = false 
	intro_play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if shake > 0:
		$CanvasLayer/Control.position = Vector2(randf_range(-shake, shake), randf_range(-shake, shake))
		shake = move_toward(shake, 0, delta * 30)
	else:
		position = Vector2.ZERO


func intro_play():
	shader_animation.play("screen_open")
	$CanvasLayer/Control/Label.text = ""
	$CanvasLayer.visible = true 
	await get_tree().create_timer(1.5).timeout
	Global.music_style = "boss"
	$CanvasLayer/Control/AnimationPlayer.play("intro")
	await $CanvasLayer/Control/AnimationPlayer.animation_finished
	get_tree().change_scene_to_packed(next)
