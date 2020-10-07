extends MarginContainer
class_name SideBoard

onready var deckVBC : VBoxContainer = $SideVBoxContainer/DeckVBoxContainer
onready var totalLabel : Label = $SideVBoxContainer/DeckVBoxContainer/TotalHBoxContainer/TotalvalueLabel
onready var availableLabel : Label = $SideVBoxContainer/DeckVBoxContainer/AvailableHBoxContainer/AvailablevalueLabel

func _ready():
	pass

func get_class():
	return "SideBoard"

func updatedeckcount(total : int, available : int) -> void:
	totalLabel.text = String(total)
	availableLabel.text = String(available)

#func _process(delta):
#	pass
