extends Control
class_name CardGUI

# 子节点
var _cardButton : TextureButton
var _cardpanelLabel : RichTextLabel

# 初始化字典变量
var id : int
var event : Dictionary
var action : Dictionary
var iscovered : bool # 是否盖牌
var isevent : bool # 是否作为事件

# 非初始化字典的变量
var index : int # 在抽出来行动卡牌堆中的序号
var real_capacity : int
var shortcut : String # 快捷键
var actionpaneltxt := "[行动]: {actiondesc}\n[能力值]: +{actioncapa}\n[技能]: {actionskilldesc}\n"
var eventpaneltxt := "[事件]: {eventdesc}\n[克服难度]: +{eventdiff}\n"
var cover : Resource
var backcover : Resource


func init(dict : Dictionary) -> void:
	_cardButton = $CardMarginContainer/CardTextureButton
	_cardpanelLabel = $CardMarginContainer/CardTextureButton/CardPopupPanel/CardRichTextLabel
	
	id = dict["id"]
	event = dict["event"]
	action = dict["action"]
	iscovered = dict["iscovered"]
	isevent = dict["isevent"]
	
	real_capacity = action["capacity"]
	cover = load(dict["cover"])
	backcover = load(dict["backcover"])
	visible = false
	
	update_button()
	update_panel()
	
	
func update_button() -> void:
	_cardButton.texture_normal = backcover if iscovered else cover

func update_panel() -> void:
	var paneltxt : String
	if isevent:
		paneltxt = eventpaneltxt + "\n--------------------\n" + actionpaneltxt
	else:
		paneltxt = actionpaneltxt + "\n--------------------\n" + eventpaneltxt
		
	_cardpanelLabel.text = paneltxt
	

func _init_paneltxt():
	actionpaneltxt = actionpaneltxt.format({
		"actiondesc" : action["desc"],
		"actioncapa" : action["capacity"],
		"actionskilldesc" : action["skilldesc"],
	})
	
	eventpaneltxt = eventpaneltxt.format({
		"eventdesc" : event["desc"],
		"eventdiff" : event["difficulty"],
	})

func get_id() -> int:
	return id

func _ready():
	pass

func get_class() -> String:
	return "CardGUI"
