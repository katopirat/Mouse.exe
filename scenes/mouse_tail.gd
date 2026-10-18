extends Line2D
@onready var start = $TailStart
@export var max_length = 170
@export var spacing = 6.0
func _ready() -> void:
	top_level = true
	clear_points()

func _process(delta: float) -> void:
	var start = to_local(start.global_position)
	if get_point_count() == 0:
		add_point(start)
		add_point(start)
	
	set_point_position(0, start)
	
	if start.distance_to(get_point_position(1)) > spacing:
		add_point(start,1)
	
	tail()

func tail():
	var t_length := 0.0
	
	for i in range(get_point_count() - 1):
		var len = get_point_position(i).distance_to(get_point_position(i + 1))
		t_length += len
		
		if t_length > max_length:
			while get_point_count() > i + 1:
				remove_point(get_point_count() - 1)
			break
