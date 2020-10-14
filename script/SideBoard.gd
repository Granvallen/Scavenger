extends MarginContainer
class_name SideBoard

signal game_over

onready var foodLabel : Label = $SideVBoxContainer/StateVBoxContainer/FoodHBoxContainer/FoodvalueLable
onready var deckVBC : VBoxContainer = $SideVBoxContainer/DeckVBoxContainer
onready var totalLabel : Label = $SideVBoxContainer/DeckVBoxContainer/TotalHBoxContainer/TotalvalueLabel
onready var availableLabel : Label = $SideVBoxContainer/DeckVBoxContainer/AvailableHBoxContainer/AvailablevalueLabel

func _ready() -> void:
	pass

func get_class() -> String:
	return "SideBoard"

func game_setup() -> void:
	pass

func update_deckcount(actiondeck : DeckGUI) -> void:
	totalLabel.text = String(actiondeck.totalnumcards)
	availableLabel.text = String(actiondeck.get_num_cards())
	
func update_food(food : int) -> void:
	food += int(foodLabel.text)	
	foodLabel.text = String(food if food > 0 else 0)
	
	if food <= 0:
		emit_signal("game_over")

#func _process(delta):
#	pass
