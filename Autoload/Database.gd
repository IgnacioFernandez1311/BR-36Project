class_name DB extends Node


const FILEPATH = "user://config.save"

var Global_data: Dictionary = {
		"level" : {
			"number" : 0,
			"room_name" : "PuenteRoom"
		},
		"inventory": [],
		"fullscreen" : false,
		"music" : true,
		"text_anim" : true,
		"shader_effect" : true,
		"sfx": true
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
