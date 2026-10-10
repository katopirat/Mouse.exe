extends Node2D
@onready var bitcoin_price_label: Label = $Control/LabelBitcoinPrice
@onready var money_label: Label = $LabelMoney
@onready var bitcoin_label: Label = $LabelBitcoin
@onready var buy_button = $"../BuyButton"
@onready var sell_button = $"../SellButton"
@export var starting_price: int = 1000
@export var time_between_change: float = 0.7
@onready var bitcoin_price: int = starting_price
@onready var bitcoin_bought:float = 0.25
@onready var player_money: float = 500.0
@onready var max_change: float = 0.11
@onready var min_change: float = -0.1
@onready var how_much_multi: float = 0.50
@onready var stara = starting_price
@onready var continuity: float = 1.001
@onready var streak: int = 0
signal bitcoin_price_changed(new_value: float)
signal bought_bitcoin(price: float)
signal sold_bitcoin(price: float)
signal money_to_spend(money: float)
var time_accumulated: float = 0.0
func _ready() -> void:
	randomize()

	buy_button.buy_bitcoin.connect(_on_buy_button_buy_bitcoin)
	sell_button.sell_bitcoin.connect(_on_sell_button_buy_bitcoin)
	bitcoin_price_changed.emit(starting_price)
func _process(delta: float) -> void:
	money_label.text = '$' + str(round(player_money))
	money_to_spend.emit(player_money)
	bitcoin_label.text = str(snapped(bitcoin_bought, 0.01)) + "B"
	time_accumulated += delta
	if time_accumulated >= time_between_change:
		bitcoin_price = max(10, int(randf_range(1+min_change, 1+max_change) * bitcoin_price)) # toto taky - ok
		
		
		bitcoin_price_label.text = str(bitcoin_price)
		if bitcoin_price > stara:
			bitcoin_price_label.modulate = Color.GREEN
			max_change *= continuity
			if streak >= 0:
				streak += 1
			else:
				streak = 1 
			if streak > 3:
				max_change /= continuity
		else:
			bitcoin_price_label.modulate = Color.RED
			min_change *= continuity
			if streak <= 0:
				streak -= 1
			else:
				streak = -1 
			if streak < -5:
				min_change /= continuity
		var stara = bitcoin_price
		create_tween().tween_property(bitcoin_price_label, "modulate", Color.WHITE, 0.4)
		
		bitcoin_price_changed.emit(bitcoin_price)
		print(bitcoin_price)
		time_accumulated -= time_between_change #sorry toto jsem upravil aby to bylo hezci - ok
		
func _on_buy_button_buy_bitcoin():
	if player_money > 0:
		
		bought_bitcoin.emit(bitcoin_price)
	if how_much_multi < 0:
		how_much_multi = 0.50
	elif not how_much_multi == 1.00:
		how_much_multi += 0.25
	bitcoin_bought += (player_money*how_much_multi)/bitcoin_price
	player_money -= how_much_multi*player_money
func _on_sell_button_buy_bitcoin():
	if bitcoin_bought > 0:
		sold_bitcoin.emit(bitcoin_price)
	if how_much_multi > 0:
		how_much_multi = -0.5
	elif not how_much_multi == -1.00:
		how_much_multi -= 0.25
	player_money += bitcoin_bought*bitcoin_price*(-how_much_multi)
	bitcoin_bought -= bitcoin_bought*(-how_much_multi)


func _on_mouse_pad_ad_ad_bought(price: float) -> void:
	player_money -= price
