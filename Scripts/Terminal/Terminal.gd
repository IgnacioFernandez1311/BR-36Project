class_name Terminal extends Resource

export(Resource) var terminal_info: Resource
export(Resource) var terminal_item: Resource

func on_scan(current_room: PanelContainer) -> String:
	return "[ Informe sobre la Terminal de %s ]: %s" % [Types.wrap_text(current_room.room_name, Types.COLOR_LOCATION), terminal_info.info]

func on_use_terminal(player: Player) -> String:
	if terminal_item != null:
		return "%s" % [_give_item(player)]
	return "Esta terminal no funciona"

func _give_item(player: Player) -> String:
	var terminal_response : String = _has_item_to_give(player)
	terminal_item = null
	return terminal_response

func _has_item_to_give(player: Player) -> String:
	if terminal_item != null:
		player.pickup_item(terminal_item)
		return "La terminal abrio su expendedora y te ha dado [ %s ]" % Types.wrap_text(terminal_item.item_name, Types.COLOR_ITEM)
	return ""

