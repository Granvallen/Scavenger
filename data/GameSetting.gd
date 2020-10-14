extends Object
class_name GameSetting

func get_deck_setting(decktype : int) -> Dictionary:
	var deck : Dictionary = decks[decktype]
	deck["decktype"] = decktype
	deck["cards"] = []
	deck["dropcards"] = []
	return deck

const num_init_actioncards := 2
const num_rollevent := 2

const chats := {
	"add_eventcards" : "事件发生,选择一个事件进行克服.",
	"add_actionboard" : "抽取[D]行动牌克服困难,可以消耗食物获得额外抽卡.",
}

const decks := {
	DeckGUI.DeckType.ACTION : {
		"visible" : true,
		"cover" : "res://resource/cards/back.png",
		"shortcut" : KEY_D,
	},
	DeckGUI.DeckType.EVENT : {
		"visible" : false,
		"cover" : "res://resource/cards/back.png",
		"shortcut" : KEY_UNKNOWN,
	},
}
