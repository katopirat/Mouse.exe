extends Node2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D 
@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var time_shown: float = 4.0
@onready var achievement_text: Label = $Label

func play_achievement(name: String):
	print("playing")
	sprite.play(name)
	achievement_text.text = name
	animation.play("pop_up")
	await get_tree().create_timer(time_shown).timeout
	animation.play_backwards("pop_up")
