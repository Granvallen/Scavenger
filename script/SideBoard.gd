extends MarginContainer
class_name SideBoard

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

func update_deckcount(total : int, available : int) -> void:
	totalLabel.text = String(total)
	availableLabel.text = String(available)

#func _process(delta):
#	pass
