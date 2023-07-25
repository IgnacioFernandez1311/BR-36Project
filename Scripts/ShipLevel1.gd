extends Node2D

var dormitory_exit: RoomExit
var control_room_exit: RoomExit
onready var dormitory_key: Item = RoomsManager.load_item("KeyDormitoryItem")
onready var repair_key: Item = RoomsManager.load_item("RepairKey")
onready var joseph_diary: Item = RoomsManager.load_item("JosephQuestItem")
onready var joseph_npc: Npc = RoomsManager.load_npc("JosephDurl")
onready var janks_npc: Npc = RoomsManager.load_npc("JanksPilgrim")
onready var engine_machine: Machine = RoomsManager.load_machine("Engine1")
onready var janks_item: Item = RoomsManager.load_item("JanksItem")

func level_init() -> void:
	_puente_room_init()
	_control_room_init()
	_exclusa()
#	_camaras_room_init()
	_pasillo_room_init()
	_sala_reuniones_room_init()
	_ascensor_init()

func _puente_room_init() -> void:
	$PuenteRoom.add_npc(janks_npc)
	janks_npc.set_quest_reward(dormitory_key)
	$PuenteRoom.add_item(janks_item)
	$PuenteRoom.add_machine(engine_machine)
	$PuenteRoom.add_item(joseph_diary)
	

func _control_room_init() -> void:
	control_room_exit = $ControlRoom.connect_exit_unlocked("exclusa", $Exclusa, "control")

func _exclusa() -> void:
	$Exclusa.connect_exit_unlocked("control", $ControlRoom, "exclusa")

func _pasillo_room_init() -> void:
	$PasilloRoom.connect_exit_unlocked("puente",$PuenteRoom,"pasillo")
	$PasilloRoom.connect_exit_unlocked("camaras",$CamarasRoom,"pasillo")
	$PasilloRoom.connect_exit_unlocked("reuniones",$ReunionesRoom,"pasillo")

func _sala_reuniones_room_init() -> void:
	$ReunionesRoom.connect_exit_unlocked("comedor", $ComedorRoom, "reuniones")
	$ReunionesRoom.connect_exit_unlocked("ascensor", $Ascensor, "reuniones")

func _ascensor_init() -> void:
	$Ascensor.connect_exit_unlocked("abajo", get_parent().get_node("Level2").get_node("Ascensor"))

#func _dormitorio_room_init() -> void:
#	$DormitorioRoom.add_npc(joseph_npc)
#	joseph_npc.set_quest_reward(repair_key)
#	repair_key.set_item_use_value(engine_machine)



