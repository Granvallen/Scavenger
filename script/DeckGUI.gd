extends Control
class_name DeckGUI

signal draw_card(cards)

enum DeckType {EVENT, ACTION}

# 子节点
var _deckTB : TextureButton
var _deckLabel : Label
var _deckPanel : PopupPanel
var _deckdescLabel : RichTextLabel

var _cards : Array # 抽牌堆
var _dropcards : Array # 弃牌堆
var cover : Resource
var decktype : int
var shortcut : int
var totalnumcards : int

func _ready() -> void:
	pass

func init(deck_initdict : Dictionary) -> DeckGUI:
	_deckTB = $DeckMarginContainer/DeckTextureButton
	_deckLabel = $DeckMarginContainer/DeckTextureButton/DeckShortcutLabel
	_deckPanel = $DeckMarginContainer/DeckTextureButton/DeckPopupPanel
	_deckdescLabel = $DeckMarginContainer/DeckTextureButton/DeckPopupPanel/DeckRichTextLabel
	
	_signal_connect()
	
	decktype = deck_initdict["decktype"]
	cover = load(deck_initdict["cover"])
	shortcut = deck_initdict["shortcut"]
	
	# GUI
	visible = deck_initdict["visible"]
	_deckLabel.text = "[{shortcut}]".format({"shortcut" : char(shortcut)})
	
	_deckTB.texture_normal = cover
	# 快捷键
	_deckTB.shortcut = ShortCut.new()
	_deckTB.shortcut.shortcut = InputEventKey.new()
	_deckTB.shortcut.shortcut.scancode = shortcut
	
	# 卡牌
	_cards = deck_initdict["cards"]
	_dropcards = deck_initdict["dropcards"]
	
	totalnumcards = _cards.size()
	return self

func _draw_card() -> void:
	emit_signal("draw_card", draw(1))
	
func _signal_connect() -> void:
	_deckTB.connect("pressed", self, "_draw_card")

func draw(num_card : int) -> Array:
	# 如果牌不够抽, 回收弃牌堆
	if num_card >= _cards.size():
		_dropcards.shuffle()
		_cards = _dropcards + _cards
		_dropcards.clear()
	
	var draw_cards : Array
	draw_cards = _cards.slice(-num_card, _cards.size()) # 从后面抽卡
	_cards = _cards.slice(0, -num_card - 1)
	return draw_cards

func drop(cards : Array) -> void:
	for card in cards:
		# 重置card参数
		card.isenable = true
		card.iscovered = false
		card.isevent = true if decktype == DeckType.EVENT else false
		card.real_value = card.event["difficulty"] if decktype == DeckType.EVENT else card.action["capacity"]
		card.update_button()
		card.update_panel()

		_dropcards.append(card)
		
	if _cards.size() == 0:
		_dropcards.shuffle()
		_cards = _dropcards + _cards
		_dropcards.clear()
		
	totalnumcards = max(totalnumcards, _cards.size() + _dropcards.size())

func get_num_cards() -> int:
	return _cards.size()
	

func debug() -> void:
	print("hello!")
	print(shortcut)
	print(_deckTB.shortcut.shortcut.scancode)

#func _process(delta):
#	pass
