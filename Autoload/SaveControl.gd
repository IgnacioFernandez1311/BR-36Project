extends Node

const FILEPATH = "user://SAVEFILE.save"

var data : Dictionary = {
	"level" : {
		"level_number" : 0,
		"room_name" : "CabinaRoom"
	},
	"inventory": [],
	"fullscreen" : false,
	"glow" : false,
	"music" : false
}

func _ready() -> void:
	load_data()

func save_data() -> void:
	var file : File = File.new()
	var _file_opened : int = file.open(FILEPATH, File.WRITE)
	file.store_var(data)
	file.close()

func save_custom_data(filepath : String, custom_data : Dictionary) -> void:
	var file : File = File.new()
	var _file_opened : int = file.open(filepath, File.WRITE)
	file.store_var(custom_data)
	file.close()

func load_custom_data(filepath : String, custom_data : Dictionary) -> void:
	var file : File = File.new()
	var _file_opened : int = file.open(filepath, File.READ)
	
	if !file.file_exists(filepath):
		save_custom_data(filepath, custom_data)
	else:
		custom_data = file.get_var()
	save_custom_data(filepath, custom_data)
	file.close()
	

func load_data() -> void:
	var file : File = File.new()
	var _file_opened : int = file.open(FILEPATH,File.READ)
	
	if !file.file_exists(FILEPATH):
		save_data()
	else:
		data = file.get_var()
	save_data()
	file.close()


