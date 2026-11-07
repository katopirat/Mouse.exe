extends Node2D
@onready var cable = $Line2D
@onready var cable_start = %CableStart
@onready var cable_end = %CableEnd
@onready var player = $".."
@export var max_length = 600
@export var color = Color()
@export var stressed_color = Color(0.378, 0.0, 0.0, 1.0)
@export var cursor_exists: bool = true
@onready var wrapped_foot: bool = false
@onready var tight: bool = false
@onready var touch_points = []  
var points = []
var lenght = 0.0

func calculate_intersect(a: Vector2, b: Vector2, c: Vector2) -> Vector2:
	var ac: Vector2 = c - a

	if ac.length_squared() == 0.0:
		return a

	var t: float = (b - a).dot(ac) / ac.length_squared()

	t = clampf(t, 0.0, 1.0)

	return a + t * ac

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
			
			if strike.collider == $"../../Boss/Foot" and !wrapped_foot:
				for point in points:
					if point.distance_to(new_point) < 10:
						print("touch")
						touch_points.append([point, new_point])
						wrapped_foot = true
			points.append(new_point)
			if wrapped_foot:
				var new_touch_points = []
				for t in touch_points:
					if t[0] in points and t[1] in points:
						new_touch_points.append(t)
				touch_points = new_touch_points
				if touch_points.is_empty():
					wrapped_foot = false

	var start_point: int = 0
	while start_point < points.size() - 1:
		var start = points[start_point]
		var end
		if start_point == points.size() -2:
			end = cable_end.global_position
		else:
			end = points[start_point+2]
		var strike_before = space.intersect_ray(PhysicsRayQueryParameters2D.create(start, end, 4))
		if strike_before:
			start_point+=1
		else:
			var triangle := ConvexPolygonShape2D.new()
			triangle.points = PackedVector2Array([
			start,
			points[start_point + 1],
			end
			])

			var query := PhysicsShapeQueryParameters2D.new()
			query.shape = triangle
			query.collision_mask = 4

			var hits = space.intersect_shape(query)
			print(hits)
			if hits.is_empty():
				points.pop_at(start_point + 1)
			else:
				start_point += 1


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
		if wrapped_foot:
			print("kill")
		if cursor_exists:
			$"../Monitor_2/Computer/Cursor".speed = 0
	else:
		cable.default_color = color
		if cursor_exists:
			$"../Monitor_2/Computer/Cursor".speed = 10
