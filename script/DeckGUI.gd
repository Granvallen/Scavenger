extends Control
class_name DeckGUI

enum DeckType {EVENT, ACTION, DROP}

var _cardgui := preload("res://scene/CardGUI.tscn")

# 子节点
var _deckTB : TextureButton
var _deckLabel : Label
var _deckPanel : PopupPanel
var _deckdescLabel : RichTextLabel

var _cards : Array
var cover : Resource
var decktype : int
var shortcut : int

func _ready():
	pass

func init(deck_initdict : Dictionary) -> void:
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
	_deckTB.shortcut = ShortCut.new()
	_deckTB.shortcut.shortcut = InputEventKey.new()
	_deckTB.shortcut.shortcut.scancode = shortcut
	
	# 初始化卡牌
	var newcard : CardGUI
	for card_initdict in deck_initdict["cards_initdict"]:
		newcard = _cardgui.instance()
		newcard.init(card_initdict)
	
		_cards.append(newcard)


func get_num_cards() -> int:
	return _cards.size()

func debug() -> void:
	print("hello!")
	print(shortcut)
	print(_deckTB.shortcut.shortcut.scancode)

#func _process(delta):
#	pass
