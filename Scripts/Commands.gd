class_name Commands extends Node

func read_commands(words: PoolStringArray, command_handler: CommandHandler) -> String:
	if words.size() == 0:
		return "Error: No hay comandos que puedan ser procesados..."
	var first_word: String = words[0].to_lower()
	var second_word: String = ""
	if words.size() > 1:
		second_word = words[1].to_lower()
	
	match first_word:
		"apagar":
			command_handler.quit()
			return Types.wrap_text("Apagando sistemas...",Types.COLOR_SYSTEM)
		"ayuda":
			return command_handler.help()
		"ir": 
			return command_handler.go(second_word)
		"recoger":
			return command_handler.take_item(second_word)
		"soltar":
			return command_handler.drop_item(second_word)
		"usar":
			return command_handler.use(second_word)
		"hablar":
			return command_handler.talk(second_word)
		"dar":
			return command_handler.give_item(second_word)
		"inventario":
			return command_handler.inventory()
		"escanear":
			return command_handler.scan(second_word)
		"limpiar":
			command_handler.game_info.delete_history()
			return Types.wrap_text("Consola Limpia", Types.COLOR_SYSTEM)
		_:
			return Types.wrap_text("Comando no reconocido... puedes usar el comando %s para ver los comandos a tu disposicion.", Types.COLOR_SYSTEM) % [Types.wrap_text('"ayuda"', Types.COLOR_NPC)]
