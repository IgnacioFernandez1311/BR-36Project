class_name CommandHandler extends Node

signal room_changed(new_room)
signal room_updated(current_room)

export(NodePath) var game_info_path: NodePath
onready var game_info: PanelContainer = get_node(game_info_path)
export(NodePath) var player_path: NodePath
onready var player: Player = get_node(player_path)
onready var commands: Node = get_node("Commands")

var current_room: GameRoom = null setget set_current_room


func initialize(starting_room: GameRoom) -> String:
	return change_room(starting_room)

func handle_command(input: String) -> String:
	var words: PoolStringArray = input.split(" ", true)
	return commands.read_commands(words, self)

func go(second_word: String) -> String:
	if second_word == "":
		return Types.wrap_text("Ir a donde?...", Types.COLOR_SYSTEM)
	
	if current_room.exits.keys().has(second_word):
		var exit: RoomExit = current_room.exits[second_word]
		if exit.room_is_locked:
			return "La puerta hacia "+Types.wrap_text(second_word.capitalize(),Types.COLOR_LOCATION)+" esta bloqueada..."
		var change_response = change_room(exit.get_other_room(current_room))
		return PoolStringArray(["Te movilizas hacia "+ Types.wrap_text(second_word.capitalize(),Types.COLOR_LOCATION), change_response]).join("\n")
	
	return "Esta habitacion no tiene salida hacia "+Types.wrap_text(second_word.capitalize(),Types.COLOR_LOCATION)
	

func talk(second_word: String) -> String:
	if second_word == "":
		return Types.wrap_text("Hablar con quien?...",Types.COLOR_SYSTEM)
	
	for npc in current_room.npcs:
		if second_word.to_lower() == npc.npc_name.to_lower():
			if npc.dialogs.size() == 0:
				return Types.wrap_text("No puedes hablar con %s" % Types.wrap_text(npc.npc_display_name, Types.COLOR_NPC), Types.COLOR_SYSTEM)
			var dialog : String = npc.on_talk()
			return "%s: \"%s\"" % [Types.wrap_text(npc.npc_display_name,Types.COLOR_NPC), dialog]
	return "Esta persona no se encuentra en esta habitacion."

func take_item(second_word: String) -> String:
	if second_word == "":
		return "Tomar que?..."
	for item in current_room.items:
		if second_word.to_lower() == item.item_name.to_lower():
			current_room.remove_item(item)
			player.pickup_item(item)
			emit_signal("room_updated", current_room)
			return "Has añadido [ "+Types.wrap_text(item.item_name.capitalize(),Types.COLOR_ITEM)+" ] a tu inventario"
	return "Ese item no se encuentra en esta habitacion..."


func drop_item(second_word: String) -> String:
	if second_word == "":
		return Types.wrap_text("Soltar que?...",Types.COLOR_SYSTEM)
	for item in player.inventory:
		if second_word.to_lower() == item.item_name.to_lower():
			player.drop_item(item)
			current_room.add_item(item)
			emit_signal("room_updated", current_room)
			return "Has dajado [ "+Types.wrap_text(item.item_name.capitalize(),Types.COLOR_ITEM)+" ] en "+Types.wrap_text(current_room.room_name.capitalize(), Types.COLOR_LOCATION)+"..."
	return "Ese item no se encuentra en tu inventario..."

func give_item(second_word: String) -> String:
	if second_word == "":
		return Types.wrap_text("Dar que?...", Types.COLOR_SYSTEM)
	
	var has_item: bool = false
	for item in player.inventory:
		if second_word.to_lower() == item.item_name.to_lower():
			has_item = true
	
	if !has_item:
		return "No tienes ese item en tu inventario..."
	
	for npc in current_room.npcs:
		if npc.quest_item != null and second_word.to_lower() == npc.quest_item.item_name.to_lower():
			player.drop_item(npc.quest_item)
			return npc.on_give_item(player)
	return "este npc no se encuentra en esta habitacion."

func inventory() -> String:
	return player.get_inventory_list()

func scan(second_word: String) -> String:
	if second_word == "":
		return "inspeccionar que?..."
	for npc in current_room.npcs:
		if second_word.to_lower() == npc.npc_name.to_lower():
			return npc.on_scan()
	for item in player.inventory:
		if second_word.to_lower() == item.item_name.to_lower():
			return item.on_scan()
	for machine in current_room.machines:
		if second_word.to_lower() == machine.machine_name.to_lower():
			return machine.on_scan()
	if second_word.to_lower() == "terminal".to_lower():
		return current_room.room_terminal.on_scan(current_room)
	return "Este item no se encuentra el inventario"

func use(second_word: String) -> String:
	if second_word == "":
		return "Usar que?..."
	for item in player.inventory:
		if second_word.to_lower() == item.item_name.to_lower():
			return item.on_use(current_room, player, self)
	if second_word.to_lower() == "terminal":
		return current_room.room_terminal.on_use_terminal(player)
	return "Ese item no se encuentra en tu inventario..."

func quit() -> void:
	yield(get_tree().create_timer(1.5), "timeout")
	SceneTransition.change_scene("res://Scenes/SplashScreen.tscn", "dissolve")
	

static func help() -> String:
	return "%s:\n%s" % [Types.wrap_text("Estos son los comandos que se encuentran a tu disposición",Types.COLOR_SYSTEM), 
		"- ir [localizacion]\n- inventario\n- recoger [item]\n- soltar [item]\n- usar [item]\n- escanear [item/maquina/personaje]\n- apagar\n- ayuda."]


func set_current_room(new_room: GameRoom) -> void:
	current_room = new_room

func change_room(new_room: GameRoom) -> String:
	set_current_room(new_room)
#	if new_room.get_parent().is_in_group("Level1"):
#		Database.Global_data.level.level_number = 0
#	if new_room.get_parent().is_in_group("Level2"):
#		Database.Global_data.level.level_number = 1
#	if new_room.get_parent().is_in_group("Level3"):
#		Database.Global_data.level.level_number = 2
#	Database.Global_data.level.room_name = new_room.to_string()
#	SaveControl.save_data(Database.Global_data)
	emit_signal("room_changed", new_room)
	return new_room.get_full_description()
