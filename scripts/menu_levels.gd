extends Button

@export var scene:PackedScene
@onready var shader_animation = $"../CanvasLayer/AnimationTree"

func _ready() -> void:
	pressed.connect(_on_pressed)

func _process(delta: float) -> void:
	pass


func _on_pressed() -> void:
	shader_animation.play("close_screen")
	await shader_animation.animation_finished
	get_tree().change_scene_to_packed(scene)
