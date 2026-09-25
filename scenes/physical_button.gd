extends Area2D
var pressed = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(_on_body_entered) # Replace with function body.
	body_exited.connect(_on_body_exited)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass





func _on_body_exited(body: Node2D) -> void:
	print(body.name)
	modulate = Color(1,1, 1, 1.0)
	pressed = false


func _on_body_entered(body: Node2D) -> void:
	modulate = Color(0.812, 0.0, 0.112, 1.0)
	pressed = true
