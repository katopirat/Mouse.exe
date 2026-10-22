extends Node2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D 
@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var time_shown: float = 4.0

func play_achievement(name: String):
	sprite.play(name)
	animation.play("pop_up")
	await get_tree().create_timer(time_shown).timeout
	animation.play_backwards("pop_up")
func _ready() -> void:
	play_achievement("placeholder")
