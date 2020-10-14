extends Control
class_name CardGUI

signal card_picked(card)

# 卡牌GUI
var _cardgui := load("res://scene/CardGUI.tscn")

# 子节点
var cardTB : TextureButton
var cardLabel : Label
var cardPP : PopupPanel
var cardpanelRTL : RichTextLabel

# 初始化字典变量
var id : int
var event : Dictionary
var action : Dictionary
var iscovered : bool # 是否盖牌
var isenable : bool
var isevent : bool # 是否作为事件

# 非初始化字典的变量
var index : int # 在抽出来行动卡牌堆中的序号
var real_value : int
var shortcut : String # 快捷键
var actionpaneltxt := "[行动]:{actiondesc}\n[能力值]:+{actioncapa}\n[技能]:{actionskilldesc}\n[移除代价]:{removecost}\n"
var eventpaneltxt := "[事件]:{eventdesc}\n[克服难度]:{eventdiff}\n[抽卡机会]:{chance}\n"
var cover : Resource
var backcover : Resource

func init(dict : Dictionary) -> CardGUI:
	cardTB = $CardMarginContainer/CardTextureButton
	cardLabel = $CardMarginContainer/CardTextureButton/CardvalueLabel
	cardPP = $CardMarginContainer/CardTextureButton/CardPopupPanel
	cardpanelRTL = $CardMarginContainer/CardTextureButton/CardPopupPanel/CardRichTextLabel
	
	_signal_connect()
	
	id = dict["id"]
	event = dict["event"]
	action = dict["action"]
	iscovered = dict["iscovered"]
	isevent = dict["isevent"]
	isenable = dict["isenable"]
	
	real_value = event["difficulty"] if isevent else action["capacity"]
	cover = load(dict["cover"])
	backcover = load(dict["backcover"])
	visible = false
	
	_init_paneltxt()
	
	update_button()
	update_panel()
	
	return self

func flip() -> void:
	iscovered = not iscovered
	update_button()

func reverse() -> void:
	isevent = not isevent
	real_value = event["difficulty"] if isevent else action["capacity"]
	update_panel()

func switch() -> void:
	isenable = not isenable
	cardTB.disabled = not cardTB.disabled

func _card_picked() -> void:
	if not iscovered:
		emit_signal("card_picked", self)

func update_button() -> void:
	cardTB.disabled = not isenable
	cardTB.texture_normal = backcover if iscovered else cover
	cardLabel.text = "[{real_value}]".format({"real_value" : real_value})

func update_panel() -> void:
	var paneltxt : String
	if isevent:
		paneltxt = eventpaneltxt + "---------------------\n" + actionpaneltxt
	else:
		paneltxt = actionpaneltxt + "---------------------\n" + eventpaneltxt

	cardpanelRTL.text = paneltxt

func _init_paneltxt() -> void:
	actionpaneltxt = actionpaneltxt.format({
		"actiondesc" : action["desc"],
		"actioncapa" : action["capacity"],
		"actionskilldesc" : action["skilldesc"],
		"removecost" : action["removecost"],
	})
	
	eventpaneltxt = eventpaneltxt.format({
		"eventdesc" : event["desc"],
		"eventdiff" : event["difficulty"],
		"chance" : event["chance"],
	})

func get_id() -> int:
	return id

func _signal_connect() -> void:
	cardTB.connect("pressed", self, "_card_picked")
	cardTB.connect("mouse_entered", self, "_on_CardTB_mouse_entered")
	cardTB.connect("mouse_exited", self, "_on_CardTB_mouse_exited")

func _on_CardTB_mouse_entered():
	_show_Panel_and_follow()
	cardPP.visible = false if iscovered else true

func _on_CardTB_mouse_exited():
	cardPP.visible = false

func _show_Panel_and_follow():
	var mpos = get_global_mouse_position()
	var psize = cardPP.rect_size
	var vsize = get_viewport_rect().size
	mpos += Vector2(15, 0)
	mpos.y = min(mpos.y, vsize.y - psize.y - 5)
	mpos.x = min(mpos.x, vsize.x - psize.x - 5)
	cardPP.rect_position = mpos

func _process(delta):
	if cardPP and cardPP.visible:
		_show_Panel_and_follow()

func copy(card : CardGUI) -> CardGUI:
	cardTB = $CardMarginContainer/CardTextureButton
	cardLabel = $CardMarginContainer/CardTextureButton/CardvalueLabel
	cardPP = $CardMarginContainer/CardTextureButton/CardPopupPanel
	cardpanelRTL = $CardMarginContainer/CardTextureButton/CardPopupPanel/CardRichTextLabel
	
	_signal_connect()
	
	id = card.id
	event = card.event
	action = card.action
	iscovered = card.iscovered
	isevent = card.isevent
	isenable = card.isenable
	
	real_value = event["difficulty"] if isevent else action["capacity"]
	cover = card.cover
	backcover = card.backcover
	visible = card.visible
	
	_init_paneltxt()
	
	update_button()
	update_panel()
	
	return self

func clone() -> CardGUI:
	return _cardgui.instance().copy(self)

func _ready() -> void:
	pass

func get_class() -> String:
	return "CardGUI"
