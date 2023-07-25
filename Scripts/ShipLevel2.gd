extends Node2D

onready var joseph_npc: Npc = RoomsManager.load_npc("JosephDurl")
onready var joseph_diary: Item = RoomsManager.load_item("JosephQuestItem")
onready var repair_key: Item = RoomsManager.load_item("RepairKey")
onready var engine_machine: Machine = RoomsManager.load_machine("Engine1")
onready var dormitory_key: Item = RoomsManager.load_item("KeyDormitoryItem")

var dormitory_exit: RoomExit

func level_init() -> void:
#	_hangar_room_init()
	_capsulas_room_init()
	_pasillo_init()
	_ascensor_init()
	_control_room_init()
	_torretas_room_init()
	_dormitorio_room_init()


#func _hangar_room_init() -> void:
#	$HangarRoom.connect_exit_unlocked("capsulas", $CapsulasRoom, "hangar")

func _capsulas_room_init() -> void:
	$CapsulasRoom.connect_exit_unlocked("pasillo", $PasilloRoom, "capsulas")
	$CapsulasRoom.connect_exit_unlocked("hangar", $HangarRoom, "capsulas")

func _pasillo_init() -> void:
	$PasilloRoom.connect_exit_unlocked("ascensor", $Ascensor, "pasillo")
	$PasilloRoom.connect_exit_unlocked("comunicaciones", $ComunicacionesRoom, "pasillo")
	$PasilloRoom.connect_exit_unlocked("control", $ControlRoom, "pasillo")

func _ascensor_init() -> void:
	$Ascensor.connect_exit_unlocked("arriba", get_parent().get_node("Level1").get_node("Ascensor"))

func _control_room_init() -> void:
	$ControlRoom.connect_exit_unlocked("enfermeria", $EnfermeriaRoom, "control")
	dormitory_exit = $ControlRoom.connect_exit_locked("dormitorio", $DormitorioRoom, "control")
	dormitory_key.set_item_use_value(dormitory_exit)
	$ControlRoom.connect_exit_unlocked("torretas", $TorretasRoom, "control")

func _torretas_room_init() -> void:
	$TorretasRoom.connect_exit_unlocked("seguridad", $SeguridadRoom, "torretas")
	$TorretasRoom.connect_exit_unlocked("motores", $MotoresRoom, "torretas")
	$TorretasRoom.connect_exit_unlocked("exclusa", $Exclusa, "torretas")
	

func _dormitorio_room_init() -> void:
	$DormitorioRoom.add_npc(joseph_npc)
	joseph_npc.set_quest_reward(repair_key)
	repair_key.set_item_use_value(engine_machine)
