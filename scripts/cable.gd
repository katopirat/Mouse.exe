extends Node2D
@onready var cable = $Line2D
@onready var cable_start = %CableStart
@onready var cable_end = %CableEnd
@onready var player = $".."
@export var max_length = 600
var points = []
var last_position = Vector2(0,0)
@export var color = Color()
@export var stressed_color = Color(0.378, 0.0, 0.0, 1.0)

var lenght = 0.0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if points.is_empty():
		points.append(cable_start.global_position)
	var space = get_world_2d().direct_space_state
	var strike = space.intersect_ray(PhysicsRayQueryParameters2D.create(points[-1], cable_end.global_position, 4))
	
	if strike:
		print(strike.position)
		points.append(strike.position + strike.normal * 3)
	if points.size() > 1:
		var strike_before = space.intersect_ray(PhysicsRayQueryParameters2D.create(points[-2], cable_end.global_position, 4))
		if  not strike_before:
			points.pop_back()
	
	cable.clear_points()
	for a in points:
		cable.add_point(cable.to_local(a))
		if points.size() > 1:
			lenght += points[-2].distance_to(points[-1])
	
	lenght = 0.0
	for i in range(points.size()-1):
		lenght += points[i].distance_to(points[i+1])
	cable.add_point(cable.to_local(cable_end.global_position))
	
	if points.size() > 1:
		lenght += points[-1].distance_to(cable_end.global_position)
	else:
		lenght += cable_start.global_position.distance_to(cable_end.global_position)
	print(lenght)
	
	if lenght > max_length:
		var navic = lenght - max_length
		player.global_position = player.global_position.move_toward(points[-1], navic * 0.5)
		cable.default_color = stressed_color
	else:
		last_position = player.position
		cable.default_color = color
