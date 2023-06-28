tool
class_name GameRoom extends PanelContainer

export(String) var room_name: String = "Nombre Habitacion" setget set_room_name
export(String, MULTILINE) var room_description: String = "Esta es la descripcion de la habitacion." setget set_room_description
export(Resource) var room_terminal: Resource

var exits: Dictionary = {}
var npcs: Array = []
var machines: Array = []
var items: Array = []

func set_room_name(new_room_name: String) -> void:
	$MarginContainer/Rows/RoomName.text = new_room_name
	room_name = new_room_name

func set_room_description(new_room_description: String) -> void:
	$MarginContainer/Rows/RoomDescription.text = new_room_description
	room_description = new_room_description

func add_npc(npc: Npc) -> void:
	npcs.append(npc)

func remove_npc(npc: Npc) -> void:
	npcs.erase(npc)

func add_item(item: Item) -> void:
	items.append(item)

func remove_item(item: Item) -> void:
	items.erase(item)

func add_machine(machine: Machine) -> void:
	machines.append(machine)

func get_full_description() -> String:
	var full_description: PoolStringArray = PoolStringArray([get_room_description()])
	
	var npc_description: String = get_npc_description()
	if npc_description != "":
		full_description.append(npc_description)
	var item_description: String = get_item_description()
	if item_description != "":
		full_description.append(item_description)
	var machine_description: String = get_machine_description()
	if machine_description != "":
		full_description.append(machine_description)
	full_description.append(get_exit_description())
	
	var full_description_string: String = full_description.join("\n")
	return full_description_string

func get_room_description() -> String:
	return "> Ahora estas en %s.\n %s" % [room_name, room_description]

func get_npc_description() -> String:
	if npcs.size() == 0:
		return ""
	
	var npc_string: String = ""
	for npc in npcs:
		npc_string += npc.npc_name + " "
	return "NPCs: "+ Types.wrap_text(npc_string, Types.COLOR_NPC)

func get_machine_description() -> String:
	if machines.size() == 0:
		return ""
	
	var machine_string: String = ""
	var machine_text_color: Color
	for machine in machines:
		machine_text_color = Types.COLOR_MACHINE if !machine.machine_is_repaired else Types.COLOR_SPEECH
		machine_string += Types.wrap_text(machine.machine_name, machine_text_color) + " "
	return "Maquinas: "+ machine_string

func get_exit_description() -> String:
	return "Salidas: " + Types.wrap_text(PoolStringArray(exits.keys()).join(" "), Types.COLOR_LOCATION)

func get_item_description() -> String:
	if items.size() == 0:
		return ""
	
	var item_string: String = ""
	for item in items:
		item_string += item.item_name + " "
	return "Items: "+ Types.wrap_text(item_string, Types.COLOR_ITEM)


func connect_exit_unlocked(direction: String, room: GameRoom, room_2_override_name: String = "null") -> RoomExit:
	return _connect_exit(direction, room, false, room_2_override_name)

func connect_exit_locked(direction: String, room: GameRoom, room_2_override_name: String = "null") -> RoomExit:
	return _connect_exit(direction, room, true, room_2_override_name)

func _connect_exit(direction: String, room: Node, is_locked: bool = false, room_2_override_name: String = "null") -> RoomExit:
	
	var room_exit: RoomExit = RoomExit.new()
	room_exit.set_first_room(self)
	room_exit.set_second_room(room)
	room_exit.room_is_locked = is_locked
	exits[direction] = room_exit
	
	direction = direction.to_lower()
	
	if room_2_override_name != "null":
		room.exits[room_2_override_name] = room_exit
	else:
		match direction:
			"este":
				room.exits["oeste"] = room_exit
			"oeste":
				room.exits["este"] = room_exit
			"norte":
				room.exits["sur"] = room_exit
			"sur":
				room.exits["norte"] = room_exit
			"arriba":
				room.exits["abajo"] = room_exit
			"abajo":
				room.exits["arriba"] = room_exit
			"dentro":
				room.exits["fuera"] = room_exit
			"fuera":
				room.exits["dentro"] = room_exit
			_:
				printerr("Se intento conectar una direccion invalida: %s" % direction)
	return room_exit








