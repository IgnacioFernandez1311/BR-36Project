class_name RoomsManager extends Node

onready var levels: Array = self.get_children()

func _ready() -> void:
	for level in levels:
		if level.has_method("level_init"):
			level.level_init()
	
	
static func load_item(item_name: String) -> Resource:
	return load("res://Resources/Items/%s.tres" % item_name)

static func load_npc(npc_name: String) -> Resource:
	return load("res://Resources/Npcs/%s.tres" % npc_name)

static func load_machine(machine_name: String) -> Resource:
	return load("res://Resources/Machines/%s.tres" % machine_name)
