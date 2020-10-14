extends VBoxContainer
class_name TurnBox

signal add_item # 使页面始终更新到最下面

var _eventGUI := preload("res://scene/EventVBoxContainer.tscn")
var _chatGUI := preload("res://scene/ChatMarginContainer.tscn")
var _actionGUI := preload("res://scene/ActionVBoxContainer.tscn")

# 子节点
var _event : EventVBoxContainer
var _eventchat : ChatMarginContainer
var _action : ActionVBoxContainer
var _actionchat : ChatMarginContainer

var _pickedevent : CardGUI
var _gamesetting : GameSetting

var _turn : int

func _ready() -> void:
	pass

func init(gamesetting : GameSetting, turn : int) -> TurnBox:
	_gamesetting = gamesetting
	_turn = turn
	return self

func add_eventcards(eventcards : Array) -> void:
	_eventchat = _chatGUI.instance().init(_gamesetting.chats["add_eventcards"])
	_event = _eventGUI.instance().init(_turn)
	
	for card in eventcards:
		card.visible = true
		_event.add_card(card)

	self.add_child(_eventchat)
	self.add_child(_event)
	
	emit_signal("add_item")

func add_actioncards(actioncards : Array) -> void:
	for card in actioncards:
		card.visible = true
		_action.add_card(card)
		
	emit_signal("add_item")

# 创建 actionboard
func add_actionboard() -> ActionVBoxContainer:
	_actionchat = _chatGUI.instance().init(_gamesetting.chats["add_actionboard"])
	_action = _actionGUI.instance().init(_turn)

	self.add_child(_actionchat)
	self.add_child(_action)

	self.update_value()
	self.update_chance(_pickedevent["event"]["chance"])
	
	emit_signal("add_item")
	
	return _action

func get_actioncards(isduplicate : bool = false) -> Array:
	return _action.get_cards(isduplicate)
	
func get_eventcards(isduplicate : bool = false) -> Array:
	return _event.get_cards(isduplicate)

func cover_eventcards_except(card : CardGUI) -> void:
	_pickedevent = card
	for _card in _event.get_cards():
		_card.switch()

		if _card.id != card.id:
			_card.flip()

func update_chance(chance : int) -> int:
	return _action.update_chance(chance)

func update_value() -> void:
	_action.update_value(_pickedevent.real_value)

func get_class() -> String:
	return "TurnBox"

func _process(delta):
	pass
