extends Object
class_name GameSetting

func get_deck_setting(decktype : int) -> Dictionary:
	var deck : Dictionary = decks[decktype]
	deck["decktype"] = decktype
	
	return deck

const num_init_actioncards := 1

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
	DeckGUI.DeckType.DROP : {
		"visible" : false,
		"cover" : "res://resource/cards/back.png",
		"shortcut" : KEY_UNKNOWN,
	},
}
