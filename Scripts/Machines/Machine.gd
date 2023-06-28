class_name Machine extends Resource

export(String) var machine_name: String = ""
export(String, MULTILINE) var machine_description: String = ""

export(Resource) var repair_item: Resource

var machine_is_repaired: bool = false

func on_scan() -> String:
	var machine_color: Color = Types.COLOR_SPEECH if machine_is_repaired else Types.COLOR_MACHINE
	var needs_reparation: String = "Esta maquina necesita reparaciones. Necesitas %s para repararlo." % Types.wrap_text(repair_item.item_name, Types.COLOR_ITEM) if !machine_is_repaired else "Esta maquina se encuentra plenamente funcional."
	if machine_description == "":
		return "No hay informacion sobre esta maquina en la base de datos"
	return "[ Informe sobre %s ]: %s\n%s" % [Types.wrap_text(machine_name, machine_color), machine_description, needs_reparation]
