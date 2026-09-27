extends Area2D
@export var speed: float = 250.0
signal score_awarded

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	
func _physics_process(delta: float) -> void:
	position.x -= speed * delta
	if position.x < -58:
		score_awarded.emit()
		queue_free()
		
func _on_body_entered(body: Node2D) -> void:
	print(body.get_groups())
	if body.is_in_group("dino"):
		body.kill()
