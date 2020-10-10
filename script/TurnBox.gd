extends VBoxContainer
class_name TurnBox

var _eventGUI := preload("res://scene/EventVBoxContainer.tscn")
var _chatGUI := preload("res://scene/ChatMarginContainer.tscn")
var _actionGUI := preload("res://scene/ActionVBoxContainer.tscn")

# 子节点
var _event : VBoxContainer
var _eventchat : MarginContainer
var _action : VBoxContainer
var _actionchat : MarginContainer


var _pickedevent : CardGUI
var _gamesetting : GameSetting



func _ready() -> void:
	pass

func init(gamesetting) -> TurnBox:
	_gamesetting = gamesetting
	return self

func add_eventcards(eventcards : Array) -> void:
	_eventchat = _chatGUI.instance().init(_gamesetting.chats["add_eventcards"])
	_event = _eventGUI.instance().init()
	
	for card in eventcards:
		card.visible = true
		_event.add_card(card)
		
	self.add_child(_eventchat)
	self.add_child(_event)

func add_actioncards(actioncards : Array) -> void:
	for card in actioncards:
		card.visible = true
		_action.add_card(card)

func add_actionboard() -> void:
	_actionchat = _chatGUI.instance().init(_gamesetting.chats["add_actionboard"])
	_action = _actionGUI.instance().init()
	
	self.add_child(_actionchat)
	self.add_child(_action)

func coverall_except(card : CardGUI) -> void:
	_pickedevent = card
	for _card in _event.get_cards():
		if _card.id != card.id:
			_card.flip()
	
func update_value() -> void:
	_action.update_value(_pickedevent.real_value)

func get_class() -> String:
	return "TurnBox"


func _process(delta):
	pass
