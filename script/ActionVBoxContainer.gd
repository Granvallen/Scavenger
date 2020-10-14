extends VBoxContainer
class_name ActionVBoxContainer

signal event_overcome
signal event_pass

var _cardGC : GridContainer
var _actionLabel : Label
var _chanceLabel : Label
var _capacityLabel : Label
var _difficultyLabel : Label
var _overcomeButton : Button
var _passButton : Button

func _ready() -> void:
	pass

func init(turn : int) -> ActionVBoxContainer:
	_cardGC = $ActionMarginContainer/CardGridContainer
	_actionLabel = $ChoiceHBoxContainer/ActionLabel
	_chanceLabel = $ChoiceHBoxContainer/ChancevalueLabel
	_capacityLabel = $ChoiceHBoxContainer/CapacityvalueLabel
	_difficultyLabel = $ChoiceHBoxContainer/DifficultyvalueLabel
	_overcomeButton = $ChoiceHBoxContainer/OvercomeButton
	_passButton = $ChoiceHBoxContainer/PassButton
	
	_actionLabel.text = "[行动 #{turn}]".format({"turn" : turn})
	_signal_connect()
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

func update_value(difficulty : int) -> void:
	var capacity := 0
	for card in _cardGC.get_children():
		if card.iscovered:
			continue
		capacity += card.real_value

	_capacityLabel.text = "{capacity}".format({"capacity" : capacity})
	_difficultyLabel.text = "{difficulty}".format({"difficulty" : difficulty})
	
	
	# 更新按钮状态
	if capacity >= difficulty:
		_overcomeButton.disabled = false
		_passButton.disabled = true
	else:
		_overcomeButton.disabled = true
		_passButton.disabled = false

func update_chance(chance : int) -> int:
	chance += int(_chanceLabel.text)
	_chanceLabel.text = String(chance if chance > 0 else 0)
	return chance

func _signal_connect() -> void:
	_overcomeButton.connect("pressed", self, "overcomeButton_pressed")
	_passButton.connect("pressed", self, "passButton_pressed")


func overcomeButton_pressed() -> void:
	emit_signal("event_overcome")
	
func passButton_pressed() -> void:
	emit_signal("event_pass")

#func _process(delta):
#	pass
