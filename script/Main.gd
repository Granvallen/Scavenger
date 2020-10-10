extends MarginContainer

# 子节点
onready var _playboard : PlayBoard = $MainHBoxContainer/PlayBoard
onready var _sideboard : SideBoard = $MainHBoxContainer/SideBoard

var _carddealer = load("res://script/CardDealer.gd").new()
var eventcount := 0 # 回合计数

func _ready():
	randomize()

	signal_connect()
	game_setup()
	roll_event()

func signal_connect() -> void:
	_carddealer.connect("update_deckcount", _sideboard, "update_deckcount")
	_carddealer.connect("game_setup", _sideboard, "game_setup")

func game_setup() -> void:
	_carddealer.game_setup(_sideboard.deckVBC)

func roll_event() -> void:
	_carddealer.roll_event(_playboard.playboardVBC)







#func _process(delta):
#	pass
