extends Node2D

@export var scene: PackedScene
@onready var dialog = $"cutscene intro/Node2D/AnimatedSprite2D/DialogWindow"
@onready var ants_anim: AnimationPlayer = $AnimationPlayer2

func _ready() -> void:
	Global.music_style = "dramatic"
	await dialog.window_closed
	ants_anim.play("new_animation")
	await ants_anim.animation_finished
	get_tree().change_scene_to_packed(scene)
