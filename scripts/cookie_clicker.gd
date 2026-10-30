extends Node2D

@onready var player_money: float = 0.0

@onready var money_per_click: float = 0.05
@onready var click_power_cost: float = 10.0

@onready var autoclicker_cps: float = 0
@onready var autoclicker_cost: float = 1

@onready var money_label: Label = $MoneyLabel

@onready var cps_label: Label = $CpsLabel
@onready var cps: float
@onready var clicks: int = 0

signal click_label(power: float)
signal update_money(money: float)

func click(ignore_click: bool = false):
	player_money = snapped(player_money + money_per_click, 0.01)
	click_label.emit(money_per_click)
	if not ignore_click:
		clicks += 1
func _ready() -> void:
	start_cps_counter()
	
	$Upgrades/ClickPower/CostLabel.text = "$" + str(click_power_cost)
	$Upgrades/ClickPower/ValueLabel.text = str(money_per_click) + "/click"
	$Upgrades/Autoclicker/CostLabel.text = "$1"
	$Upgrades/Autoclicker/ValueLabel.text = "not owned"
func _on_cookie_cookie_clicked() -> void:
	click()
func _process(delta: float) -> void:
	money_label.text = "$" + str(player_money)
	update_money.emit(player_money)
func start_cps_counter():
	clicks = 0
	await get_tree().create_timer(1).timeout
	print(autoclicker_cps)
	cps = clicks+autoclicker_cps
	cps_label.text = str(cps) + " cps"
	start_cps_counter()
	


func _on_click_power_upgrade() -> void:
	if click_power_cost > player_money:
		return
	player_money -= click_power_cost
	click_power_cost = snapped(click_power_cost*1.8, 0.01)
	money_per_click = snapped(money_per_click*2, 0.01)
	$Upgrades/ClickPower/CostLabel.text = "$" + str(click_power_cost)
	$Upgrades/ClickPower/ValueLabel.text = str(money_per_click) + " /click"

func _on_autoclicker_upgrade() -> void:
	if autoclicker_cost > player_money:
		return
	player_money -= autoclicker_cost
	autoclicker_cost = snapped(autoclicker_cost*1.25, 0.01)
	
	if autoclicker_cps == 0:
		autoclicker_cps = 1
		autoclicker(autoclicker_cps)
	else:
		
		autoclicker_cps += floori(autoclicker_cps)*0.25
		
	$Upgrades/Autoclicker/ValueLabel.text = str(autoclicker_cps) + " cps"
	$Upgrades/Autoclicker/CostLabel.text = "$" + str(autoclicker_cost)
func autoclicker(cps: float):
	if cps == 0: 
		return
	await get_tree().create_timer(1/cps).timeout
	click(true)
	autoclicker(autoclicker_cps)
	


func _on_disapear_button_bought_button(price: int) -> void:
	player_money -= price
