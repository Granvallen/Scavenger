extends MarginContainer

# 子节点
onready var _playboard : PlayBoard = $MainHBoxContainer/PlayBoard
onready var _sideboard : SideBoard = $MainHBoxContainer/SideBoard


var _carddealer = load("res://script/CardDealer.gd").new()
var eventcount := 0 # 回合计数



func _ready():
	signal_connect()
	game_setup()
	roll_event()
	pass

func signal_connect() -> void:
	_carddealer.connect("updatedeckcount", _sideboard, "updatedeckcount")

func game_setup() -> void:
	_carddealer.init_deck(_sideboard.deckVBC)

func roll_event() -> void:
	

#func _process(delta):
#	pass
