extends RigidBody2D

@onready var player: CharacterBody2D = $"../Player"


func _ready() -> void:
	pass # Replace with function body.


# sigma if your looking here
func _physics_process(delta: float) -> void:
	apply_central_force(global_position.direction_to(player.global_position)*200)

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	rotation = state.linear_velocity.angle()
