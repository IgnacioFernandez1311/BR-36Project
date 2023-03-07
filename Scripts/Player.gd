extends Node

var inventory : Array = []

func _ready() -> void:
	inventory = SaveControl.data.inventory

func pickup_item(item : Item):
	inventory.append(item)
	SaveControl.data.inventory = inventory

func drop_item(item : Item):
	inventory.erase(item)
	SaveControl.data.inventory = inventory

func get_inventory_list() -> String:
	if inventory.size() == 0:
		return "No hay objetos en el inventario..."
	
	var item_string : String = ""
	for item in inventory:
		item_string += item.item_name + " "
	return "Inventario: [ %s ]" % Types.wrap_text(item_string.capitalize(), Types.COLOR_ITEM)
