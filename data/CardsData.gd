extends Object
class_name CardsData

func get_cards_initdict(ids : Array, deck_type : int) -> Array:
	var isevent := true if deck_type == DeckGUI.DeckType.EVENT else false
	var iscovered := false
	
	var cards := []
	var card : Dictionary
	for id in ids:
		card = _cards[id]
		# 公共变量
		card["cover"] = coverdir + "{id}.png".format({"id" : id})
		card["backcover"] = backcover
		card["action"]["skilldesc"] = skillsdesc[card["action"]["skill"]]
		# 其他
		card["isevent"] = isevent
		card["iscovered"] = iscovered
		cards.append(card)

	return cards

func get_num_cards() -> int:
	return _cards.size()

# 公共变量
const coverdir := "res://resource/cards/"
const backcover := "res://resource/cards/back.png"
const skillsdesc := {
	0 : "无特殊效果.",
	1 : "选择一张可用行动卡,其能力值翻倍.",
}

# 卡牌
const _cards := [
	{
		"id" : 0,
		"event" : {
			"desc" : "下雨了,检查避难所漏水情况...",
			"difficulty" : 0,
		},
		"action" : {
			"desc" : "修理.",
			"capacity" : 1,
			"skill" : 1,
		},
	},
	{
		"id" : 1,
		"event" : {
			"desc" : "下雨了,检查避难所漏水情况...",
			"difficulty" : 1,
		},
		"action" : {
			"desc" : "修理.",
			"capacity" : 2,
			"skill" : 1,
		},
	},
	{
		"id" : 2,
		"event" : {
			"desc" : "下雨了,检查避难所漏水情况...",
			"difficulty" : 3,
		},
		"action" : {
			"desc" : "修理.",
			"capacity" : 3,
			"skill" : 1,
		},
	},
	{
		"id" : 3,
		"event" : {
			"desc" : "下雨了,检查避难所漏水情况...",
			"difficulty" : 3,
		},
		"action" : {
			"desc" : "修理.",
			"capacity" : 3,
			"skill" : 1,
		},
	},
	{
		"id" : 4,
		"event" : {
			"desc" : "下雨了,检查避难所漏水情况...",
			"difficulty" : 3,
		},
		"action" : {
			"desc" : "修理.",
			"capacity" : 3,
			"skill" : 1,
		},
	},
]
