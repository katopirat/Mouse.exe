extends Node2D

@onready var player_money: float = 0.0

@onready var money_per_click: float = 0.05
@onready var click_power_cost: float = 50.0

@onready var autoclicker_cps: float
@onready var autoclicker_cost: float = 1

@onready var money_label: Label = $MoneyLabel

@onready var cps_label: Label = $CpsLabel
@onready var cps: int
@onready var clicks: int = 0

func click(ignore_click: bool = false):
	player_money = snapped(player_money + money_per_click, 0.01)
	if not ignore_click:
		clicks += 1
func _ready() -> void:
	start_cps_counter()
func _on_cookie_cookie_clicked() -> void:
	click()
func _process(delta: float) -> void:
	money_label.text = "$" + str(player_money)
func start_cps_counter():
	clicks = 0
	await get_tree().create_timer(1).timeout
	cps = clicks+autoclicker_cps
	cps_label.text = str(cps) + " cps"
	start_cps_counter()
	


func _on_click_power_upgrade() -> void:
	pass

func _on_autoclicker_upgrade() -> void:
	if autoclicker_cost > player_money:
		return
	player_money -= autoclicker_cost
	autoclicker_cost *= 1.25
	if not autoclicker_cps:
		autoclicker_cps = 1
		autoclicker(autoclicker_cps)
	else:
		autoclicker_cps += floori(autoclicker_cps)/10

func autoclicker(cps: float):
	if cps == 0: 
		return
	await get_tree().create_timer(1/cps).timeout
	click(true)
	autoclicker(autoclicker_cps)
	
