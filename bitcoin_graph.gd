extends Node2D
@onready var text_label: Label = $Label
@onready var buy_button = $"../BuyButton"
@onready var sell_button = $"../SellButton"
@export var starting_price: int = 1000
@export var time_between_change: float = 1.0
@onready var bitcoin_price: int = starting_price
@onready var bitcoin_bought:float = 0.0
@onready var max_change: float = 0.2
var time_accumulated: float = 0.0
func _ready() -> void:
	randomize()

	buy_button.buy_bitcoin.connect(_on_buy_button_buy_bitcoin)
	sell_button.sell_bitcoin.connect(_on_sell_button_buy_bitcoin)
func _process(delta: float) -> void:
	time_accumulated += delta
	if time_accumulated >= time_between_change:
		bitcoin_price = int(randf_range(1+max_change, 1-max_change)*bitcoin_price)
		text_label.text = str(bitcoin_price)
		print(bitcoin_price)
		time_accumulated -= 1
		
func _on_buy_button_buy_bitcoin():
	text_label.text = "buy"
func _on_sell_button_buy_bitcoin():
	text_label.text = "sell"
