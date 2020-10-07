extends VBoxContainer
class_name TurnBox

onready var _event = $EventVBoxContainer
onready	var _chat = $ChatMarginContainer
onready var _action = $ActionVBoxContainer

func _ready():
	pass


func get_class():
	return "TurnBox"



#func _process(delta):
#	pass
