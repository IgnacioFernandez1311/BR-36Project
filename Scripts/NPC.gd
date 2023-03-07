class_name NPC
extends Resource


export(String) var npc_name : String = ""
export(String) var npc_display_name : String = ""
export(String, MULTILINE) var post_quest_dialog : String = "Este es el dialogo despues de una quest de un npc..."
export(Array, String, MULTILINE) var dialogs : Array
export(Array, String, MULTILINE) var post_quest_dialogs : Array 
export(String, MULTILINE) var npc_description : String = "Esta es la descripcion del NPC"
export(Resource) var quest_item : Resource

var dialogs_counter : int = -1
var reset_dialogs_counter : bool = true
var has_received_quest_item : bool = false
var quest_reward = null

var npc_data : Dictionary = {
	"name" : "",
	"has_received_item" : false
}


func on_talk() -> String:
	var last_dialog = dialogs.size() - 1 if !has_received_quest_item else post_quest_dialogs.size() - 1
	if dialogs_counter < last_dialog:
		dialogs_counter += 1
	if has_received_quest_item:
		if reset_dialogs_counter:
			dialogs_counter = 0
			reset_dialogs_counter = false
		return post_quest_dialogs[dialogs_counter]
	return dialogs[dialogs_counter]
	
	
func on_give_item() -> void:
	has_received_quest_item = true
	if quest_reward != null:
		var reward = quest_reward
		if "room_is_locked" in reward:
			reward.room_is_locked = false
		else:
			printerr("Error: La recompensa no se ha implementado.")

func savepath(name : String) -> String:
	return "user://%s.save" % name
	
	
