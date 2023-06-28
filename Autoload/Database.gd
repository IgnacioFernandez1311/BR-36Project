class_name DB extends Node


var rooms: Dictionary = {
	"dormitory_1_data" : DBRoom.new()
}

const FILEPATH = "user://config.save"

var Global_data: Dictionary = {
		"level" : {
			"level_number" : 0,
			"room_name" : "CabinaRoom"
		},
		"inventory": [],
		"fullscreen" : false,
		"music" : false,
		"text_anim" : false,
		"shader_effect" : false,
		"sfx": false
	}


func _ready() -> void:
	load_data()

func save_data() -> void:
	var file: File = File.new()
	var _file_opened : int = file.open(FILEPATH, File.WRITE)
	file.store_var(Global_data)
	file.close()

func load_data() -> void:
	var file: File = File.new()
	var _file_opened: int = file.open(FILEPATH,File.READ)
	
	if !file.file_exists(FILEPATH):
		save_data()
	else:
		Global_data = file.get_var()
	save_data()
	file.close()



class DBRoom extends GameRoom:
	var data: Dictionary = {
		"name" : "",
		"items" : [],
		"machines" : [],
		"npcs" : []
	}
	
	func initialize_room() -> void:
		for npc in npcs:
			npc.load_data()

