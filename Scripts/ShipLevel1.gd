extends Node2D

var dormitory_1_exit : RoomExit
var control_room_exit : RoomExit
onready var dormitory_1_key : Item = get_parent().load_item("KeyDormitoryItem")
onready var repair_key : Item = get_parent().load_item("RepairKey")
onready var joseph_npc : NPC = get_parent().load_npc("JosephDurl")
onready var janks_npc : NPC = get_parent().load_npc("JanksPilgrim")
onready var engine_machine : Machine = get_parent().load_machine("Engine1")
onready var machine : Machine = get_parent().load_machine("MaquinaDePrueba")


func level_init() -> void:
	_cabina_room_init()
	_puente_room_init()
	_control_room_init()
	_exclusa()
#	_camaras_room_init()
	_pasillo_norte_room_init()
#	_sala_reuniones_room_init()
	_ascensor_init()
	_pasillo_sur_dormitorios_init()
	_dormitorio_1_room_init()
	_pasillo_sur_popa_init()
#	_cocina_room_init()
#	_comedor_room_init()

func _cabina_room_init() -> void:
	$CabinaRoom.connect_exit_unlocked("puente", $PuenteRoom, "cabina")
	$CabinaRoom.add_npc(janks_npc)

func _puente_room_init() -> void:
	var joseph_diary : Item = get_parent().load_item("JosephQuestItem")
	$PuenteRoom.add_machine(engine_machine)
	$PuenteRoom.add_machine(machine)
	$PuenteRoom.add_item(joseph_diary)
	$PuenteRoom.add_item(dormitory_1_key)

func _control_room_init() -> void:
	control_room_exit = $ControlRoom.connect_exit_locked("pasillo", $PasilloNorte1, "control")
	joseph_npc.quest_reward = control_room_exit

func _exclusa() -> void:
	$Exclusa.connect_exit_unlocked("control", $ControlRoom, "exclusa")

func _pasillo_norte_room_init() -> void:
	$PasilloNorte1.connect_exit_unlocked("puente",$PuenteRoom,"pasillo")
	$PasilloNorte1.connect_exit_unlocked("camaras",$CamarasRoom,"pasillo")
	$PasilloNorte1.connect_exit_unlocked("reuniones",$ReunionesRoom,"norte")

#func _sala_reuniones_room_init() -> void:
#	$ReunionesRoom.connect_exit_unlocked("pasillo_norte", $PasilloNorte1, "reuniones")

func _ascensor_init() -> void:
	$Ascensor1.connect_exit_locked("reuniones", $ReunionesRoom, "ascensor")

func _pasillo_sur_dormitorios_init() -> void:
	$PasilloSur1.connect_exit_unlocked("reuniones", $ReunionesRoom, "sur")
	dormitory_1_exit = $PasilloSur1.connect_exit_locked("dormitorio1", $Dormitorio1, "pasillo")
	dormitory_1_key.use_value = dormitory_1_exit

func _dormitorio_1_room_init() -> void:
	$Dormitorio1.add_npc(joseph_npc)
	$Dormitorio1.add_item(repair_key)
	repair_key.use_value = engine_machine

func _pasillo_sur_popa_init() -> void:
	$PasilloSur2.connect_exit_unlocked("dormitorios", $PasilloSur1, "sur")
	$PasilloSur2.connect_exit_unlocked("cocina", $CocinaRoom, "pasillo")
	$PasilloSur2.connect_exit_unlocked("comedor", $ComedorRoom, "pasillo")
#
#func _cocina_room_init() -> void:
#	$CocinaRoom.connect_exit_unlocked("pasillo", $PasilloSur2, "cocina")
#
#func _comedor_room_init() -> void:
#	$ComedorRoom.connect_exit_unlocked("pasillo", $PasilloSur2, "comedor")



