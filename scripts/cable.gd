extends Node2D
@onready var cable = $Line2D
@onready var cable_start = %CableStart
@onready var cable_end = %CableEnd
@onready var player = $".."
@export var max_length = 600
@export var color = Color()
@export var stressed_color = Color(0.378, 0.0, 0.0, 1.0)

var points = []
var lenght = 0.0

func _physics_process(delta: float) -> void:
	if points.is_empty():
		points.append(cable_start.global_position)
	var space = get_world_2d().direct_space_state
	var strike = space.intersect_ray(PhysicsRayQueryParameters2D.create(points[-1], cable_end.global_position, 4))

	if strike:
		var new_point = strike.position + strike.normal * 3
		for c in strike.collider.get_children():
			if c is CollisionShape2D and c.shape is RectangleShape2D:
				var pul = c.shape.size / 2
				var corners = [Vector2(-pul.x, -pul.y), Vector2(pul.x, -pul.y), Vector2(pul.x, pul.y), Vector2(-pul.x, pul.y)]
				var shortest = 999999.0
				for r in corners:
					var corner = c.global_transform * r
					var total = points[-1].distance_to(corner) + corner.distance_to(cable_end.global_position)
					if total < shortest:
						shortest = total
						new_point = corner + (corner - c.global_position).normalized() * 3
		if points[-1].distance_to(new_point) > 1:
			points.append(new_point)

	if points.size() > 1:
		var strike_before = space.intersect_ray(PhysicsRayQueryParameters2D.create(points[-2], cable_end.global_position, 4))
		if not strike_before:
			points.pop_back()

	lenght = 0.0
	for i in range(points.size() - 1):
		lenght += points[i].distance_to(points[i + 1])
	lenght += points[-1].distance_to(cable_end.global_position)

	cable.clear_points()
	for a in points:
		cable.add_point(cable.to_local(a))
	cable.add_point(cable.to_local(cable_end.global_position))

	if lenght > max_length:
		var extra = lenght - max_length
		player.global_position = player.global_position.move_toward(points[-1], extra * 0.5)
		cable.default_color = stressed_color
		$"../Monitor_2/Computer/Cursor".speed = 0
	else:
		cable.default_color = color
		$"../Monitor_2/Computer/Cursor".speed = 10
