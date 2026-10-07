extends Node2D
@onready var bitcoin_price_label: Label = $LabelBitcoinPrice
@onready var money_label: Label = $LabelMoney
@onready var bitcoin_label: Label = $LabelBitcoin
@onready var buy_button = $"../BuyButton"
@onready var sell_button = $"../SellButton"
@export var starting_price: int = 1000
@export var time_between_change: float = 1.0
@onready var bitcoin_price: int = starting_price
@onready var bitcoin_bought:float = 0.0
@onready var player_money: float = 500.0
@onready var max_change: float = 0.2
@onready var how_much_multi: float = 0.50
signal bitcoin_price_changed(new_value: float)
var time_accumulated: float = 0.0
func _ready() -> void:
	randomize()

	buy_button.buy_bitcoin.connect(_on_buy_button_buy_bitcoin)
	sell_button.sell_bitcoin.connect(_on_sell_button_buy_bitcoin)
func _process(delta: float) -> void:
	money_label.text = str(round(player_money))
	bitcoin_label.text = str(snapped(bitcoin_bought, 0.01))
	time_accumulated += delta
	if time_accumulated >= time_between_change:
		bitcoin_price = int(randf_range(1+max_change, 1-max_change)*bitcoin_price)
		bitcoin_price_label.text = str(bitcoin_price)
		bitcoin_price_changed.emit(bitcoin_price)
		print(bitcoin_price)
		time_accumulated -= 1
		
func _on_buy_button_buy_bitcoin():
	bitcoin_price_label.text = "buy"
	if how_much_multi < 0:
		how_much_multi = 0.50
	elif not how_much_multi == 1.00:
		how_much_multi += 0.25
	bitcoin_bought += (player_money*how_much_multi)/bitcoin_price
	player_money -= how_much_multi*player_money
func _on_sell_button_buy_bitcoin():
	bitcoin_price_label.text = "sell"
	if how_much_multi > 0:
		how_much_multi = -0.5
	elif not how_much_multi == -1.00:
		how_much_multi -= 0.25
	player_money += bitcoin_bought*bitcoin_price*(-how_much_multi)
	bitcoin_bought -= bitcoin_bought*(-how_much_multi)
