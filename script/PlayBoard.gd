extends MarginContainer
class_name PlayBoard

onready var _playboardSC := $PlayBoardScrollContainer
onready var _playboardVBC := $PlayBoardScrollContainer/PlayBoardVBoxContainer
onready var _scrollbar = $PlayBoardScrollContainer.get_v_scrollbar()

var scroll_update

func _ready() -> void:
	pass

func add_turnbox(turnbox : TurnBox) -> void:
	_playboardVBC.add_child(turnbox)
	_scrollbar.max_value = 0
	turnbox.connect("add_item", self, "update_playboardSC")

func get_class() -> String:
	return "PlayBoard"

func update_playboardSC() -> void:
	yield(get_tree(), "idle_frame")
	_playboardSC.scroll_vertical = _scrollbar.max_value


#func _process(delta) -> void:
#	pass
#	_playboardSC.scroll_vertical = _scrollbar.max_value
