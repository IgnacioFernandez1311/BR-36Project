tool
class_name NpcData extends Resource

var name: String = "" setget set_name, get_name
var dialogs: Array
var dialogs_counter: int setget set_dialogs_counter, get_dialogs_counter
var filepath: String
var has_received_item: bool setget set_has_received_item

func save() -> void:
	var _data_saved: int = ResourceSaver.save(filepath,self)

func load_data() -> Resource:
	return ResourceLoader.load(filepath)

func set_name(new_name : String) -> void:
	filepath = "user://%s.tres" % new_name
	name = new_name
#	print("El nombre que se paso es: %s \nEl nuevo nombre es: %s" % [new_name, name])
	save()


func get_name() -> String:
#	print("Se ha obtenido el nombre: %s" % name)
	return name

func set_dialogs_counter(new_value : int) -> void:
	dialogs_counter = new_value
	print(String(dialogs_counter))
	save()
	

func get_dialogs_counter() -> int:
	print(String(dialogs_counter))
	return dialogs_counter

func set_has_received_item(has_recieved_quest_item : bool) -> void:
	has_received_item = has_recieved_quest_item
	print(has_received_item)
