class_name Player extends Node

var inventory: Array = []

func _ready() -> void:
	inventory = Database.Global_data.inventory

func pickup_item(item: Resource) -> void:
	inventory.append(item)
	Database.Global_data.inventory = inventory

func drop_item(item: Resource) -> void:
	inventory.erase(item)
	Database.Global_data.inventory = inventory

func get_inventory_list() -> String:
	if inventory.size() == 0:
		return "No hay objetos en el inventario..."
	
	var item_string : String = ""
	for item in inventory:
		item_string += item.item_name + " "
	return "Inventario: [ %s ]" % Types.wrap_text(item_string.capitalize(), Types.COLOR_ITEM)
