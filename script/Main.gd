extends MarginContainer

# 子节点
onready var _playboard : PlayBoard = $MainHBoxContainer/PlayBoard
onready var _sideboard : SideBoard = $MainHBoxContainer/SideBoard

var _carddealer = preload("res://script/CardDealer.gd").new()
var eventcount := 0 # 回合计数

func _ready():
	randomize()

	signal_connect()
	game_setup()
	new_turn()

func signal_connect() -> void:
	_carddealer.connect("turn_over", self, "new_turn")
	_carddealer.connect("update_deckcount", _sideboard, "update_deckcount")
	_carddealer.connect("game_setup", _sideboard, "game_setup")
	_carddealer.connect("update_food", _sideboard, "update_food")

func game_setup() -> void:
	_carddealer.game_setup(_sideboard.deckVBC)

func new_turn() -> void:
	_carddealer.roll_event(_playboard)

#func _process(delta):
#	pass
