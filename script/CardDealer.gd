extends Object
class_name CardDealer

# 信号
signal updatedeckcount(total, available) # 更新卡组计数

# 游戏设置
var _gamesetting := preload("res://data/GameSetting.gd").new()
# 卡牌
var _cardsdata := preload("res://data/CardsData.gd").new()

# 卡组GUI
var _deckgui := preload("res://scene/DeckGUI.tscn")

var _turnboxgui := preload("res://scene/TurnBox.tscn")

# 卡组
var _actiondeck : DeckGUI
var _eventdeck : DeckGUI
var _dropdeck : DeckGUI
var _turnbox : TurnBox

# 初始化牌堆
func init_deck(deckVBC : VBoxContainer) -> void:
	# 取牌
	var actioncardsid := range(_gamesetting.num_init_actioncards)
	var eventcardsid := range(_gamesetting.num_init_actioncards, _cardsdata.get_num_cards())
	
	actioncardsid.shuffle()
	eventcardsid.shuffle()
	
	var actioncards_initdict := _cardsdata.get_cards_initdict(actioncardsid, DeckGUI.DeckType.ACTION)
	var actiondeck_initdict := _gamesetting.get_deck_setting(DeckGUI.DeckType.ACTION)
	actiondeck_initdict["cards_initdict"] = actioncards_initdict
	
	var eventcards_initdict := _cardsdata.get_cards_initdict(eventcardsid, DeckGUI.DeckType.EVENT)
	var eventdeck_initdict := _gamesetting.get_deck_setting(DeckGUI.DeckType.EVENT)
	eventdeck_initdict["cards_initdict"] = eventcards_initdict
	
	var dropdeck_initdict := _gamesetting.get_deck_setting(DeckGUI.DeckType.DROP)
	dropdeck_initdict["cards_initdict"] = []
	
	# 创建牌堆
	print("创建牌堆...")
	# action
	_actiondeck = _deckgui.instance()
	_actiondeck.init(actiondeck_initdict)

	# event
	_eventdeck = _deckgui.instance()
	_eventdeck.init(eventdeck_initdict)

	# drop
	_dropdeck = _deckgui.instance()
	_dropdeck.init(dropdeck_initdict)
	
	# 加入卡组区
	deckVBC.add_child(_actiondeck)
	
	# 更新卡组计数
	emit_signal("updatedeckcount", _actiondeck.get_num_cards(), _actiondeck.get_num_cards())
	print("初始化牌堆完成")

# 产生随机事件
func roll_event() -> void:
	
	pass

# skill func
# 1
func _skill_double(card : CardGUI):
	card.action["real_capacity"] *= 2

# 技能表
var skillsfunc := {
	0 : null,
	1 : "_skill_double",
}







