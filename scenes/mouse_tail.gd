extends Sprite2D

@onready var line = $Tail
@onready var start_node = $TailStart  

@export var max_length = 170
@export var spacing = 6.0

func _ready() -> void:
	line.top_level = true
	line.clear_points()

func _process(delta: float) -> void:
	var start = start_node.global_position
	
	if line.get_point_count() == 0:
		line.add_point(start)
		line.add_point(start)
	
	line.set_point_position(0, start)
	
	if start.distance_to(line.get_point_position(1)) > spacing:
		line.add_point(start, 1)
	
	tail()

func tail():
	var t_length := 0.0
	
	for i in range(line.get_point_count() - 1):
		var segment_len = line.get_point_position(i).distance_to(line.get_point_position(i + 1))
		t_length += segment_len
		
		if t_length > max_length:
			while line.get_point_count() > i + 1:
				line.remove_point(line.get_point_count() - 1)
			break
