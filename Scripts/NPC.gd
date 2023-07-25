class_name Npc extends Resource


export(String) var npc_name: String = ""
export(String) var npc_display_name: String = ""
export(String, "Kaleg", "Humano", "Droide", "Idorian", "Knut", "Geonita", "Numidian", "Arcadian", "Hibrido") var npc_race: String = "Humano"
export(String, MULTILINE) var npc_description: String = "Esta es la descripcion del NPC"
export(Array, String, MULTILINE) var dialogs: PoolStringArray
export(Array, String, MULTILINE) var post_quest_dialogs: PoolStringArray 
export(Resource) var quest_item: Resource

var dialogs_counter: int = -1
var reset_dialogs_counter: bool = true
var has_received_quest_item: bool = false setget set_has_received_quest_item
var quest_reward: Resource = null setget set_quest_reward


func on_talk() -> String:
	if dialogs.size() == 0 || post_quest_dialogs.size() == 0:
		return "Este personaje no tiene nada que decirte"
	var last_dialog = dialogs.size() - 1 if !has_received_quest_item else post_quest_dialogs.size() - 1
	if dialogs_counter < last_dialog:
		dialogs_counter += 1
	if has_received_quest_item:
		if reset_dialogs_counter:
			dialogs_counter = 0
			reset_dialogs_counter = false
		return post_quest_dialogs[dialogs_counter]
	return dialogs[dialogs_counter]
	

func set_quest_reward(reward: Resource) -> void:
	quest_reward = reward

func on_scan() -> String:
	if npc_description == "":
		return "No hay informacion sobre esa persona en la base de datos"
	return "[Informe sobre: %s]: %s" % [Types.wrap_text(npc_display_name, Types.COLOR_NPC), npc_description]

func on_give_item(player: Player) -> String:
	self.set_has_received_quest_item(true)
	if quest_reward != null:
		var reward = quest_reward
		if "room_is_locked" in reward:
			reward.room_is_locked = false
			return "%s ha abierto la puerta de %s" % [Types.wrap_text(npc_display_name, Types.COLOR_NPC), Types.wrap_text(reward.room_1.room_name, Types.COLOR_LOCATION)]
		elif "item_type" in reward:
			player.pickup_item(reward)
			return "%s te ha dado %s como recompensa por traerle %s \n %s" % [Types.wrap_text(npc_display_name,Types.COLOR_NPC), Types.wrap_text(reward.item_name, Types.COLOR_ITEM), Types.wrap_text(quest_item.item_name, Types.COLOR_ITEM), Types.wrap_text(npc_display_name, Types.COLOR_NPC)+": "+'"'+on_talk()+'"' ]
		else:
			printerr("Error: La recompensa no se ha implementado.")
			return "No hay recompensa disponible"
	return "No puedes darle este item a %s" % npc_display_name

func set_has_received_quest_item(has_received_item: bool) -> void:
	has_received_quest_item = has_received_item
