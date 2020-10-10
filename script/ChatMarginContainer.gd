extends MarginContainer
class_name ChatMarginContainer

var _chatLabel : RichTextLabel


func _ready() -> void:
	pass

func init(text : String = "") -> ChatMarginContainer:
	_chatLabel = $ChatRichTextLabel
	_chatLabel.text = text
	return self

func set_text(text : String) -> void:
	_chatLabel.text = text


func get_class() -> String:
	return "ChatMarginContainer"

#func _process(delta):
#	pass
