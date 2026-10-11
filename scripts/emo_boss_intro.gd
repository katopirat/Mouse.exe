extends Control
@export var shake = 0
@export var next : PackedScene
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
	$CanvasLayer/Control/Label.text = ""
	$CanvasLayer.visible = true 
	await get_tree().create_timer(1.5).timeout
	$CanvasLayer/Control/AnimationPlayer.play("intro")
	await $CanvasLayer/Control/AnimationPlayer.animation_finished
	get_tree().change_scene_to_packed(next)
