extends Control

# Odkaz na uzel Line2D, který bude graf kreslit
@onready var line_2d: Line2D = $GraphLine2D
@onready var value_line_og: Line2D = $ValueLine2D
@export var max_data_points: int = 20
@export var line_space: float = 500.0
# Vaše pole float hodnot (můžete ho předvyplnit)
@onready var data_points: Array[float] = []

func _ready() -> void:
	# První vykreslení grafu při spuštění
	update_graph()

# Funkce, kterou zavoláte, kdykoliv chcete přidat novou hodnotu
func add_value(new_value: float) -> void:
	data_points.append(new_value)
	update_graph()

# Hlavní logika pro přepočet bodů a vykreslení grafu
func update_graph() -> void:
	# Pokud nemáme žádná data, vyčistíme graf a skončíme
	if data_points.is_empty():
		line_2d.clear_points()
		return
	else:
		data_points = data_points.slice(-max_data_points)

	line_2d.clear_points()

	# Zjistíme aktuální rozměry Control uzlu pro správné škálování
	var graph_width: float = size.x
	var graph_height: float = size.y

	# Najdeme nejvyšší hodnotu, abychom graf vertikálně roztáhli na maximum (min. 1.0 kvůli dělení nulou)
	var max_value: float = data_points.max()
	if max_value <= 0:
		max_value = 1.0

	# Spoření rozestupů na ose X mezi jednotlivými body
	var total_points: int = data_points.size()
	var x_step: float = graph_width / (total_points - 1) if total_points > 1 else graph_width

	# Vykreslení jednotlivých bodů
	for i in range(total_points):
		var x_pos: float = i * x_step
		
		var y_ratio: float = data_points[i] / max_value
		var y_pos: float = graph_height - (y_ratio * graph_height)
		
		# Přidáme bod do Line2D uzlu
		line_2d.add_point(Vector2(x_pos, y_pos))
	for i in range(0):
		pass

func _on_graph_bitcoin_price_changed(new_value: float) -> void:
	add_value(new_value)
