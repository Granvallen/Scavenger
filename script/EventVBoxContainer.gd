extends VBoxContainer
class_name EventVBoxContainer

var _eventLabel : Label
var _cardGC : GridContainer

func _ready() -> void:
	pass

func init() -> EventVBoxContainer:
	_eventLabel = $EventLabel
	_cardGC = $EventMarginContainer/CardScrollContainer/CardGridContainer
	return self

func add_card(card : CardGUI) -> void:
	_cardGC.add_child(card)
	
func get_cards() -> Array:
	return _cardGC.get_children()

func get_class() -> String:
	return "EventVBoxContainer"

#func _process(delta):
#	pass
