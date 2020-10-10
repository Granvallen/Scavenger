extends VBoxContainer
class_name ActionVBoxContainer

var _cardGC : GridContainer
var _capacityLabel : Label
var _difficultyLabel : Label
var _overcomeButton : Button
var _passButton : Button

func _ready():
	pass

func init() -> ActionVBoxContainer:
	_cardGC = $ActionMarginContainer/CardGridContainer
	_capacityLabel = $ChoiceHBoxContainer/CapacityvalueLabel
	_difficultyLabel = $ChoiceHBoxContainer/DifficultyvalueLabel
	_overcomeButton = $ChoiceHBoxContainer/OvercomeButton
	_passButton = $ChoiceHBoxContainer/PassButton
	return self

func add_card(card : CardGUI) -> void:
	_cardGC.add_child(card)

func update_value(difficulty : int) -> void:
	var capacity := 0
	for card in _cardGC.get_children():
		if card.iscovered:
			continue
		capacity += card.real_value

	_capacityLabel.text = "{capacity}".format({"capacity" : capacity})
	_difficultyLabel.text = "{difficulty}".format({"difficulty" : difficulty})
	
	if capacity >= difficulty:
		_overcomeButton.disabled = false
		_passButton.disabled = true
	else:
		_overcomeButton.disabled = true
		_passButton.disabled = false
		
#func _process(delta):
#	pass
