extends CharacterBody2D


@onready var player = $"../../.."
@export var speed: float = 100.0
var falling: bool = false

func _ready() -> void:
	player.falling_now.connect(_on_falling)
func _on_player_moved_mouse(dir: Variant) -> void:
	velocity = dir*speed
	move_and_slide()
func _on_falling(fall):
	falling = fall
	
