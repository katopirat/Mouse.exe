extends Control

@onready var line_2d: Line2D = $GraphLine2D
@onready var value_line_og: Line2D = $ValueLine2D
@export var max_data_points: int = 30
@export var line_space: float = 500.0
@onready var data_points: Array[float] = []
@onready var value_lines: Array[Line2D] = [] 
@onready var last_y: float = 0.0
func _ready() -> void:
	update_graph()
	
	

func add_value(new_value: float) -> void:
	data_points.append(new_value)
	update_graph()

func update_graph() -> void:
	if data_points.is_empty():
		line_2d.clear_points()
		return
	else:
		data_points = data_points.slice(-max_data_points)

	line_2d.clear_points()

	var graph_width: float = size.x
	var graph_height: float = size.y

	var max_value: float = data_points.max()
	if max_value < 1000:
		max_value = 1000

	var total_points: int = data_points.size()
	var x_step: float = graph_width / (total_points - 1) if total_points > 1 else graph_width

	for i in range(total_points):
		var x_pos: float = i * x_step
		
		var y_ratio: float = data_points[i] / max_value
		var y_pos: float = graph_height - (y_ratio * graph_height)
		
		line_2d.add_point(Vector2(x_pos, y_pos))
		if i == total_points-1:
			var last_y = data_points[i]
	for c in value_lines:
		c.queue_free()
	value_lines = [] 
	for line_val in range(0, max_value, line_space):
		var new_val_line = value_line_og.duplicate()
		value_lines.append(new_val_line)
		add_child(new_val_line)
		var y_pos: float = graph_height - ((line_val/max_value)*graph_height)
		value_lines[-1].add_point(Vector2(0, y_pos))
		value_lines[-1].add_point(Vector2(graph_width, y_pos))
		var value_label: Label = value_lines[-1].get_node("ValueLineLabel")
		value_label.text = str(line_val)
		value_label.position.y = y_pos
		value_label.visible = true
	if abs(snappedi(max_value, 500)-max_value) > 50:
		var line_val = max_value
		var new_val_line = value_line_og.duplicate()
		value_lines.append(new_val_line)
		add_child(new_val_line)
		var y_pos: float = graph_height - ((line_val/max_value)*graph_height)
		value_lines[-1].add_point(Vector2(0, y_pos))
		value_lines[-1].add_point(Vector2(graph_width, y_pos))
		var value_label: Label = value_lines[-1].get_node("ValueLineLabel")
		value_label.text = str(line_val)
		value_label.position.y = y_pos
		value_label.visible = true
	if abs((floori(last_y/500)*500)-last_y) > 100:
		var line_val = last_y
		var new_val_line = value_line_og.duplicate()
		value_lines.append(new_val_line)
		add_child(new_val_line)
		var y_pos: float = graph_height - ((line_val/max_value)*graph_height)
		value_lines[-1].add_point(Vector2(0, y_pos))
		value_lines[-1].add_point(Vector2(graph_width, y_pos))
		var value_label: Label = value_lines[-1].get_node("ValueLineLabel")
		value_label.text = str(line_val)
		value_label.position.y = y_pos
		value_label.visible = true
		
		
		
func _on_graph_bitcoin_price_changed(new_value: float) -> void:
	add_value(new_value)
