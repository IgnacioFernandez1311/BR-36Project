class_name Item extends Resource

export(String) var item_name: String = "Item Name"
export(Types.ItemTypes) var item_type: int =  Types.ItemTypes.KEY_ITEM
export(String, MULTILINE) var item_description: String = ""

var use_value: Resource = null setget set_item_use_value

func on_scan() -> String:
	if item_description == "":
		return "No hay informacion sobre este item en la base de datos"
	return "[ Informe sobre %s ]\n%s" % [Types.wrap_text(item_name, Types.COLOR_ITEM), item_description]

func set_item_use_value(item_use_value: Resource) -> void:
	use_value = item_use_value


func on_use(current_room: PanelContainer, player: Player, command_handler: Node) -> String:
	match item_type:
		Types.ItemTypes.KEY_ITEM:
			for exit in current_room.exits.values():
				if exit == use_value:
					exit.room_is_locked = false
					player.drop_item(self)
					return "Has usado "+Types.wrap_text(item_name, Types.COLOR_ITEM)+" para abrir la puerta hacia "+Types.wrap_text(exit.get_other_room(current_room).room_name, Types.COLOR_LOCATION)
			return "Este item no desbloquea ninguna puerta en esta zona."
		Types.ItemTypes.REPAIR_ITEM:
			for machine in current_room.machines:
				if machine == use_value:
					machine.machine_is_repaired = true
					player.drop_item(self)
					command_handler.emit_signal("room_updated", current_room)
					return "Has usado "+Types.wrap_text(item_name, Types.COLOR_ITEM)+" para reparar:  "+Types.wrap_text(machine.machine_name, Types.COLOR_SPEECH)
			return "Este item no es el optimo para utilizarse en esta maquina"
		_:
			return "Error: Se intento usar un item invalido..."
