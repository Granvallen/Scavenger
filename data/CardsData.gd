extends Object
class_name CardsData

func get_cards_initdict(ids : Array, deck_type : int) -> Array:
	var isevent := true if deck_type == DeckGUI.DeckType.EVENT else false
	var iscovered := false
	var isenable := true
	
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
		card["isenable"] = isenable
		cards.append(card)

	return cards

func get_num_cards() -> int:
	return _cards.size()

# 卡牌公共变量
const coverdir := "res://resource/cards/" # 封面目录
const backcover := "res://resource/cards/back.png" # 背面
const skillsdesc := { # 技能描述
	0 : "无特殊效果.",
	1 : "选择一张可用行动卡,其能力值翻倍.",
}

# 卡牌
#"id" : 卡牌id
#"event" : { 事件属性
#	"desc" : 事件描述
#	"difficulty" : 克服困难度
#	"chance" : 抽卡次数
#},
#"action" : { 行动属性
#	"desc" : 行动描述
#	"capacity" : 能力值
#	"skill" : 技能
#	"removecost" : 移除卡牌代价
#},
const _cards := [
	{
		"id" : 0,
		"event" : {
			"desc" : "下雨了,检查避难所漏水情况...",
			"difficulty" : 0,
			"chance" : 2,
		},
		"action" : {
			"desc" : "修理.",
			"capacity" : 1,
			"skill" : 1,
			"removecost" : 2,
		},
	},
	{
		"id" : 1,
		"event" : {
			"desc" : "下雨了,检查避难所漏水情况...",
			"difficulty" : 1,
			"chance" : 2,
		},
		"action" : {
			"desc" : "修理.",
			"capacity" : 2,
			"skill" : 1,
			"removecost" : 2,
		},
	},
	{
		"id" : 2,
		"event" : {
			"desc" : "下雨了,检查避难所漏水情况...",
			"difficulty" : 3,
			"chance" : 2,
		},
		"action" : {
			"desc" : "修理.",
			"capacity" : 3,
			"skill" : 1,
			"removecost" : 2,
		},
	},
	{
		"id" : 3,
		"event" : {
			"desc" : "下雨了,检查避难所漏水情况...",
			"difficulty" : 3,
			"chance" : 2,
		},
		"action" : {
			"desc" : "修理.",
			"capacity" : 3,
			"skill" : 1,
			"removecost" : 2,
		},
	},
	{
		"id" : 4,
		"event" : {
			"desc" : "下雨了,检查避难所漏水情况...",
			"difficulty" : 3,
			"chance" : 2,
		},
		"action" : {
			"desc" : "修理.",
			"capacity" : 3,
			"skill" : 1,
			"removecost" : 2,
		},
	},
	{
		"id" : 5,
		"event" : {
			"desc" : "下雨了,检查避难所漏水情况...",
			"difficulty" : 3,
			"chance" : 2,
		},
		"action" : {
			"desc" : "修理.",
			"capacity" : 3,
			"skill" : 1,
			"removecost" : 2,
		},
	},
]
