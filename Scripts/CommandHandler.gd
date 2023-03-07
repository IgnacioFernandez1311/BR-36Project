extends Node

signal room_changed(new_room)
signal room_updated(current_room)

var current_room = null
var player = null


func initialize(starting_room, character) -> String:
	self.player = character
	return change_room(starting_room)

func handle_command(input : String) -> String:
	
	var words : Array = input.split(" ", false)
	if words.size() == 0:
		return "Error: No hay comandos que puedan ser procesados..."
	var first_word : String = words[0].to_lower()
	var second_word : String = ""
	if words.size() > 1:
		second_word = words[1].to_lower()
	
	match first_word:
		"apagar":
			quit()
			return Types.wrap_text("Apagando sistemas...",Types.COLOR_SYSTEM)
		"hola":
			return "Hola Como Estas?"
		"ayuda":
			return help()
		"ir": 
			return go(second_word)
		"recoger":
			return take_item(second_word)
		"soltar":
			return drop_item(second_word)
		"usar":
			return use(second_word)
		"hablar":
			return talk(second_word)
		"dar":
			return give_item(second_word)
		"inventario":
			return inventory()
		"inspeccionar":
			return inspect(second_word)
		"informe":
			return info(second_word)
		_:
			return Types.wrap_text("Comando no reconocido... puedes usar el comando 'ayuda' para ver los comandos a tu disposicion.", Types.COLOR_SYSTEM)

func go(second_word : String) -> String:
	if second_word == "":
		return Types.wrap_text("Ir a donde?...", Types.COLOR_SYSTEM)
	
	
	if current_room.exits.keys().has(second_word):
		var exit = current_room.exits[second_word]
		if exit.room_is_locked:
			return "La puerta hacia "+Types.wrap_text(second_word.capitalize(),Types.COLOR_LOCATION)+" esta bloqueada..."
		var change_response = change_room(exit.get_other_room(current_room))
		return PoolStringArray(["Te movilizas hacia "+ Types.wrap_text(second_word.capitalize(),Types.COLOR_LOCATION), change_response]).join("\n")
	
	return "Esta habitacion no tiene salida hacia "+Types.wrap_text(second_word.capitalize(),Types.COLOR_LOCATION)
	

func talk(second_word : String) -> String:
	if second_word == "":
		return Types.wrap_text("Hablar con quien?...",Types.COLOR_SYSTEM)
	
	for npc in current_room.npcs:
		if second_word.to_lower() == npc.npc_name.to_lower():
			var dialog : String = npc.on_talk() 
			return Types.wrap_text(npc.npc_display_name,Types.COLOR_NPC) + ": \"" + dialog + "\""
	return "Esta persona no se encuentra en esta habitacion."

func take_item(second_word : String) -> String:
	if second_word == "":
		return "Tomar que?..."
	for item in current_room.items:
		if second_word.to_lower() == item.item_name.to_lower():
			current_room.remove_item(item)
			player.pickup_item(item)
			emit_signal("room_updated", current_room)
			return "Has añadido [ "+Types.wrap_text(item.item_name.capitalize(),Types.COLOR_ITEM)+" ] a tu inventario"
	return "Ese item no se encuentra en esta habitacion..."


func drop_item(second_word : String) -> String:
	if second_word == "":
		return Types.wrap_text("Soltar que?...",Types.COLOR_SYSTEM)
	for item in player.inventory:
		if second_word.to_lower() == item.item_name.to_lower():
			player.drop_item(item)
			current_room.add_item(item)
			emit_signal("room_updated", current_room)
			return "Has dajado [ "+Types.wrap_text(item.item_name.capitalize(),Types.COLOR_ITEM)+" ] en "+Types.wrap_text(current_room.room_name.capitalize(), Types.COLOR_LOCATION)+"..."
	return "Ese item no se encuentra en tu inventario..."

func give_item(second_word : String) -> String:
	if second_word == "":
		return Types.wrap_text("Dar que?...", Types.COLOR_SYSTEM)
	
	var has_item : bool = false
	for item in player.inventory:
		if second_word.to_lower() == item.item_name.to_lower():
			has_item = true
	
	if !has_item:
		return "No tienes ese item en tu inventario..."
	
	for npc in current_room.npcs:
		if npc.quest_item != null and second_word.to_lower() == npc.quest_item.item_name.to_lower():
			npc.on_give_item()
			npc.npc_data.has_received_item = npc.has_received_quest_item
			SaveControl.save_custom_data(npc.savepath(npc.npc_name), npc.npc_data)
			print(npc.npc_name + " data: Saved\n" + String(npc.npc_data))
			player.drop_item(npc.quest_item)
			return "Le has dado "+Types.wrap_text(second_word.capitalize(), Types.COLOR_ITEM)+" a "+Types.wrap_text(npc.npc_display_name,Types.COLOR_NPC)+"."
	return "este npc no se encuentra en esta habitacion."

func inventory() -> String:
	return player.get_inventory_list()

func inspect(second_word : String) -> String:
	if second_word == "":
		return "inspeccionar que?..."
	for item in player.inventory:
		if second_word.to_lower() == item.item_name.to_lower():
			return item.on_inspect()
	for machine in current_room.machines:
		if second_word.to_lower() == machine.machine_name.to_lower():
			return machine.on_inspect()
	return "Este item no se encuentra el inventario"

func use(second_word : String) -> String:
	if second_word == "":
		return "Usar que?..."
	for item in player.inventory:
		if second_word.to_lower() == item.item_name.to_lower():
			match item.item_type:
				Types.ItemTypes.KEY_ITEM:
					for exit in current_room.exits.values():
						if exit == item.use_value:
							exit.room_is_locked = false
							player.drop_item(item)
							return "Has usado "+Types.wrap_text(item.item_name, Types.COLOR_ITEM)+" para abrir la puerta hacia "+Types.wrap_text(exit.get_other_room(current_room).room_name, Types.COLOR_LOCATION)
					return "Este item no desbloquea ninguna puerta en esta zona."
				Types.ItemTypes.REPAIR_ITEM:
					for machine in current_room.machines:
						if machine == item.use_value:
							machine.machine_is_repaired = true
							player.drop_item(item)
							emit_signal("room_updated", current_room)
							return "Has usado "+Types.wrap_text(item.item_name, Types.COLOR_ITEM)+" para reparar:  "+Types.wrap_text(machine.machine_name, Types.COLOR_SPEECH)
					return "Este item no es el optimo para utilizarse en esta maquina"
				_:
					return "Error: Se intento usar un item invalido..."
	return "Ese item no se encuentra en tu inventario..."


func quit() -> void:
	yield(get_tree().create_timer(2), "timeout")
	SceneTransition.change_scene("res://Scenes/SplashScreen.tscn", "dissolve")
	
func info(second_word : String) -> String:
	if second_word == "":
		return current_room.get_full_description()
	for npc in current_room.npcs:
		if npc.npc_name.to_lower() == second_word.to_lower():
			return "[Informe : %s] %s" % [Types.wrap_text(npc.npc_display_name.capitalize(), Types.COLOR_NPC),npc.npc_description]
		return "Este npc no se encuentra en esta habitacion"
	return ""

func help() -> String:
	return Types.wrap_text("Estos son los comandos que se encuentran a tu disposición => ir [localizacion], informe [personaje], inventario, recoger [item], soltar [item], usar [item], inspeccionar [item/maquina], apagar, ayuda.",Types.COLOR_SYSTEM)


func change_room(new_room : GameRoom) -> String:
	current_room = new_room
	if new_room.get_parent().is_in_group("Level1"):
		SaveControl.data.level.level_number = 0
	if new_room.get_parent().is_in_group("Level2"):
		SaveControl.data.level.level_number = 1
	if new_room.get_parent().is_in_group("Level3"):
		SaveControl.data.level.level_number = 2
	for npc in current_room.npcs:
		npc.npc_data.name = npc.npc_name
		npc.has_received_quest_item = npc.npc_data.has_received_item
		SaveControl.load_custom_data(npc.savepath(npc.npc_name),npc.npc_data)
		print(npc.npc_name + " data: Loaded\n" + String(npc.npc_data))
	SaveControl.data.level.room_name = new_room.to_string()
	SaveControl.save_data()
	emit_signal("room_changed", new_room)
	return new_room.get_full_description()
