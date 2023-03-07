class_name Machine
extends Resource

export(String) var machine_name : String = ""
export(String, MULTILINE) var machine_description : String = ""

export(Resource) var repair_item : Resource

var machine_is_repaired : bool = false

func on_inspect() -> String:
	if machine_description == "":
		return "No hay informacion sobre este item en la base de datos"
	return machine_description
