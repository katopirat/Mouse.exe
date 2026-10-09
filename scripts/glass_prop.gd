extends Area2D

var default_speed = 20.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass





func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"): 
		var cursor = body.get_node("Monitor_1/Computer/Cursor")
		if cursor:
			default_speed = cursor.speed
			cursor.speed = 0.0


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"): 
		var cursor = body.get_node("Monitor_1/Computer/Cursor")
		if cursor:
			cursor.speed = default_speed
