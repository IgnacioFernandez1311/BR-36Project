extends Node

enum ItemTypes {
	KEY_ITEM,
	QUEST_ITEM,
	REPAIR_ITEM
}

const COLOR_NPC = Color("#ff9a94")
const COLOR_ITEM = Color("#94b9ff")
const COLOR_SPEECH = Color("#c3ff94")
const COLOR_LOCATION = Color("#faff94")
const COLOR_SYSTEM = Color("#ffd394")
const COLOR_MACHINE = Color("#df3ba4")


func wrap_text(text: String, color : Color) -> String:
	return "[color=#%s]%s[/color]" % [color.to_html(), text]
