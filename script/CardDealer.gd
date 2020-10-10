extends Object
class_name CardDealer

# 信号
signal update_deckcount(total, available) # 更新卡组计数
signal game_setup

# 游戏状态
enum GameState {GAMEINIT, EVENTPICK, ACTIONTAKE, TURNOVER, GAMEOVER}

enum SkillState {WAIT, TRIGGER}

# 游戏设置
var _gamesetting := preload("res://data/GameSetting.gd").new()
# 卡牌数据
var _cardsdata := preload("res://data/CardsData.gd").new()

# 卡牌GUI
var _cardgui := preload("res://scene/CardGUI.tscn")
# 卡组GUI
var _deckgui := preload("res://scene/DeckGUI.tscn")
# turnboxGUI
var _turnboxgui := preload("res://scene/TurnBox.tscn")

# 卡组
var _actiondeck : DeckGUI
var _eventdeck : DeckGUI
var _dropdeck : DeckGUI
# 当前turnbox
var _turnbox : TurnBox
# 当前选择的 event 与 action
var _eventcard : CardGUI
var _actioncard : CardGUI

var total_actioncard : int
var gamestate : int = GameState.GAMEINIT
var skillstate : int = SkillState.WAIT

func game_setup(deckVBC : VBoxContainer) -> void:
	emit_signal("game_setup")
	init_deck(deckVBC)

# 初始化牌堆
func init_deck(deckVBC : VBoxContainer) -> void:
	total_actioncard = _gamesetting.num_init_actioncards
	# 取牌
	var actioncardsid := range(total_actioncard)
	var eventcardsid := range(total_actioncard, _cardsdata.get_num_cards())
	# 洗牌
	actioncardsid.shuffle()
	eventcardsid.shuffle()
	# action卡牌
	var actioncards_initdict := _cardsdata.get_cards_initdict(actioncardsid, DeckGUI.DeckType.ACTION)
	var actioncards := create_cards(actioncards_initdict, DeckGUI.DeckType.ACTION)
	# event卡牌
	var eventcards_initdict := _cardsdata.get_cards_initdict(eventcardsid, DeckGUI.DeckType.EVENT)
	var eventcards := create_cards(eventcards_initdict, DeckGUI.DeckType.EVENT)
	
	# 卡组初始化字典
	var actiondeck_initdict := _gamesetting.get_deck_setting(DeckGUI.DeckType.ACTION)
	actiondeck_initdict["cards"] = actioncards
	
	var eventdeck_initdict := _gamesetting.get_deck_setting(DeckGUI.DeckType.EVENT)
	eventdeck_initdict["cards"] = eventcards
	
	var dropdeck_initdict := _gamesetting.get_deck_setting(DeckGUI.DeckType.DROP)
	dropdeck_initdict["cards"] = []
	
	# 创建牌堆
	print("创建牌堆...")
	# action牌堆
	_actiondeck = _deckgui.instance().init(actiondeck_initdict)
	_actiondeck.connect("draw_card", self, "draw_action")
	
	# event牌堆
	_eventdeck = _deckgui.instance().init(eventdeck_initdict)

	# drop牌堆
	_dropdeck = _deckgui.instance().init(dropdeck_initdict)
	
	# 加入卡组区
	deckVBC.add_child(_actiondeck)
	
	# 更新卡组计数
	emit_signal("update_deckcount", total_actioncard, total_actioncard)
	
	print("初始化牌堆完成")

# 抽取随机事件
func roll_event(playboardVBC : VBoxContainer) -> void:
	_turnbox = _turnboxgui.instance().init(_gamesetting)

	# TODO: 需要处理无牌可抽
	var eventcards := _eventdeck.draw(_gamesetting.num_rollevent)
	_turnbox.add_eventcards(eventcards)
	playboardVBC.add_child(_turnbox)
	
	gamestate = GameState.EVENTPICK

# 选择事件
func pick_event(card : CardGUI) -> void:
	if gamestate != GameState.EVENTPICK:
		return

	_eventcard = card
	_turnbox.coverall_except(card)
	_turnbox.add_actionboard()
	_turnbox.update_value()
	gamestate = GameState.ACTIONTAKE

# 选择行动 触发技能
func pick_action(card : CardGUI) -> void:
	if gamestate != GameState.ACTIONTAKE:
		return

	print("pick_action: ", card.id)
	if skillstate == SkillState.WAIT:
		_actioncard = card
		skillstate = SkillState.TRIGGER
	elif skillstate == SkillState.TRIGGER:
		call(skillsfunc[_actioncard.action["skill"]], card)
		_actioncard.switch()
		_turnbox.update_value()
		skillstate = SkillState.WAIT

func draw_action(actioncards : Array) -> void:
	_turnbox.add_actioncards(actioncards)
	_turnbox.update_value()
	emit_signal("update_deckcount", total_actioncard, _actiondeck.get_num_cards())

# 初始化卡牌GUI
func create_cards(cards_initdict : Array, decktype : int) -> Array:
	var bc := "pick_event" if decktype == DeckGUI.DeckType.EVENT else "pick_action"
	# 初始化卡牌
	var _cards : Array
	var newcard : CardGUI
	for card_initdict in cards_initdict:
		newcard = _cardgui.instance().init(card_initdict)
		newcard.connect("card_picked", self, bc)
		_cards.append(newcard)

	return _cards

# skill func
# 1
func _skill_double(card : CardGUI):
	card.real_value *= 2
	card.update_button()

# 技能表
var skillsfunc := {
	0 : null,
	1 : "_skill_double",
}







