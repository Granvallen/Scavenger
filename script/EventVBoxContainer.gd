extends VBoxContainer
class_name EventVBoxContainer

var _eventLabel : Label
var _cardGC : GridContainer

func _ready() -> void:
	pass

func init(turn : int) -> EventVBoxContainer:
	_eventLabel = $EventLabel
	_cardGC = $EventMarginContainer/CardScrollContainer/CardGridContainer
	
	_eventLabel.text = "[事件 #{turn}]".format({"turn" : turn})
	return self

func add_card(card : CardGUI) -> void:
	_cardGC.add_child(card)

func get_cards(isduplicate : bool = false) -> Array:
	# TODO: 待优化
	if isduplicate:
		var cards := _cardGC.get_children()
		for _card in cards:
			_cardGC.remove_child(_card)
		for _card in cards:
			_cardGC.add_child(_card.clone())
		
		return cards
	
	return _cardGC.get_children()

func get_class() -> String:
	return "EventVBoxContainer"

#func _process(delta):
#	pass
