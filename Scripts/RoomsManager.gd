extends Node

onready var levels : Array = self.get_children()

func _ready() -> void:
	for level in levels:
		level.level_init()
	
	
func load_item(item_name : String):
	return load("res://Resources/Items/%s.tres" % item_name)

func load_npc(npc_name : String) -> Resource:
	return load("res://Resources/Npcs/%s.tres" % npc_name)

func load_machine(machine_name : String) -> Resource:
	return load("res://Resources/Machines/%s.tres" % machine_name)
