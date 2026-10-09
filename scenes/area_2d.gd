extends Area2D

@onready var shader_visuals: CanvasLayer = $"../../../../Shader_visuals"
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var collision_shape_2d_2: CollisionShape2D = $CollisionShape2D2
@onready var player:CharacterBody2D = get_tree().get_nodes_in_group("player")[0]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:





	if is_in_group("player"):
		get_tree().reload_current_scene()
