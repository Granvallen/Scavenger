extends Control
class_name DeckGUI

signal draw_card(cards)

enum DeckType {EVENT, ACTION, DROP}

# 子节点
var _deckTB : TextureButton
var _deckLabel : Label
var _deckPanel : PopupPanel
var _deckdescLabel : RichTextLabel

var _cards : Array
var cover : Resource
var decktype : int
var shortcut : int

func _ready() -> void:
	pass

func init(deck_initdict : Dictionary) -> DeckGUI:
	_deckTB = $DeckMarginContainer/DeckTextureButton
	_deckLabel = $DeckMarginContainer/DeckTextureButton/DeckShortcutLabel
	_deckPanel = $DeckMarginContainer/DeckTextureButton/DeckPopupPanel
	_deckdescLabel = $DeckMarginContainer/DeckTextureButton/DeckPopupPanel/DeckRichTextLabel
	
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
	
	_signal_connect()
	return self
	
func _draw_card() -> void:
	emit_signal("draw_card", draw(1))
	
func _signal_connect() -> void:
	_deckTB.connect("pressed", self, "_draw_card")

func draw(num_card : int) -> Array:
	var draw_cards : Array
	draw_cards = _cards.slice(-num_card, _cards.size())
	_cards = _cards.slice(0, -num_card - 1)
	return draw_cards

func get_num_cards() -> int:
	return _cards.size()

func debug() -> void:
	print("hello!")
	print(shortcut)
	print(_deckTB.shortcut.shortcut.scancode)

#func _process(delta):
#	pass
