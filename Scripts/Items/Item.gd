class_name Item
extends Resource

export(String) var item_name = "Item Name"
export(Types.ItemTypes) var item_type =  Types.ItemTypes.KEY_ITEM
export(String, MULTILINE) var item_description = ""

var use_value = null

var item_data : Dictionary = {
	"use_value" : null
}

func on_inspect() -> String:
	if item_description == "":
		return "No hay informacion sobre este item en la base de datos"
	return item_description

