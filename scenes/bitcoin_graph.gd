extends Control

@onready var line_2d: Line2D = $GraphLine2D
@onready var value_line_og: Line2D = $ValueLine2D
@export var max_data_points: int = 20
@export var line_space: float = 500.0
@onready var data_points: Array[float] = []
@onready var value_lines: Array[Line2D] = [] 
@onready var last_y: float = 0.0
@onready var min_text_distance: float = 30
@onready var last_max_val: int = 1000
@onready var price_lines: Array[Line2D] = []
func _ready() -> void:
	
	update_graph()
	
	

func add_value(new_value: float) -> void:
	data_points.append(new_value)
	data_points = data_points.slice(-max_data_points)
	if len(data_points) < max_data_points:
		for r in range(max_data_points-len(data_points)):
			data_points.append(data_points[-1])
		last_max_val = data_points.max()
	update_graph()

func update_graph() -> void:
	if data_points.is_empty():
		for l in price_lines:
			l.queue_free()
		return

	for l in price_lines:
		l.queue_free()

	var graph_width: float = size.x
	var graph_height: float = size.y

	var max_value: float = data_points.max()
	var min_value: float = data_points.min()
	if max_value - min_value < 50:
		max_value = min_value + 50
		
	last_max_val = max_value
	var total_points: int = data_points.size()
	var x_step: float = graph_width / (total_points - 1) if total_points > 1 else graph_width
	price_lines = []
	for i in range(total_points-1):
		price_lines.append(line_2d.duplicate())
		price_lines[-1].clear_points()
		add_child(price_lines[-1])
		var x_pos: float = i * x_step
		
		var y_ratio: float = (data_points[i] - min_value) / (max_value - min_value)
		var y_pos: float = graph_height - (y_ratio * graph_height)
		
		price_lines[-1].add_point(Vector2(x_pos, y_pos))
		x_pos = (i+1) * x_step
		var y_ratio_after = (data_points[i+1] - min_value) / (max_value - min_value)
		var y_pos_after = graph_height - (y_ratio_after * graph_height)
		price_lines[-1].add_point(Vector2(x_pos, y_pos_after))
		if y_pos_after > y_pos:
			
			price_lines[-1].default_color = Color(1.0, 0.0, 0.0, 1.0)
		else:
			price_lines[-1].default_color = Color(0.0, 1.0, 0.0, 1.0)
		price_lines[-1].visible = true

	var last_y = data_points[-1]
	for c in value_lines:
		c.queue_free()
	var all_value_lines_y = []
	value_lines = [] 
	if last_y:
		print("lasty ", last_y)
		var line_val = last_y
		var new_val_line = value_line_og.duplicate()
		value_lines.append(new_val_line)
		add_child(new_val_line)
		var y_pos: float = graph_height - (((line_val - min_value) / (max_value - min_value)) * graph_height)
		value_lines[-1].add_point(Vector2(0, y_pos))
		value_lines[-1].add_point(Vector2(graph_width, y_pos))
		var value_label: Label = value_lines[-1].get_node("ValueLineLabel")
		value_label.text = str(int(line_val))
		value_label.position.y = y_pos
		value_label.visible = true
		all_value_lines_y.append(y_pos)
	if max_value:
		var line_val = max_value
		var new_val_line = value_line_og.duplicate()
		value_lines.append(new_val_line)
		add_child(new_val_line)
		var y_pos: float = graph_height - (((line_val - min_value) / (max_value - min_value)) * graph_height)
		value_lines[-1].add_point(Vector2(0, y_pos))
		value_lines[-1].add_point(Vector2(graph_width, y_pos))
		var value_label: Label = value_lines[-1].get_node("ValueLineLabel")
		if abs(last_y) > min_text_distance:	
			value_label.text = str(int(line_val))
			value_label.position.y = y_pos
			value_label.visible = true
			all_value_lines_y.append(y_pos)
		else:
			value_label.visible = false
		
	for i in range(5):
		var line_val = min_value + (max_value - min_value) * i / 4.0
		var new_val_line = value_line_og.duplicate()
		value_lines.append(new_val_line)
		add_child(new_val_line)
		var y_pos: float = graph_height - (((line_val - min_value) / (max_value - min_value)) * graph_height)
		value_lines[-1].add_point(Vector2(0, y_pos))
		value_lines[-1].add_point(Vector2(graph_width, y_pos))
		var min_distance = 10000
		for dist in all_value_lines_y:
			if abs(y_pos-dist) < min_distance:
				min_distance = abs(y_pos-dist)
		var value_label: Label = value_lines[-1].get_node("ValueLineLabel")
		if min_distance > min_text_distance:
			value_label.text = str(line_val)
			value_label.position.y = y_pos
			value_label.visible = true
			all_value_lines_y.append(y_pos)
		else:
			value_label.visible = false
		
		
		
		
func _on_graph_bitcoin_price_changed(new_value: float) -> void:
	add_value(new_value)
