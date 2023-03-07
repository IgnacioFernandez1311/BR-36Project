extends Node2D

func level_init() -> void:
	_capsulas_room_init()
	_pasillo_norte_init()
	_pasillo_central_init()
	_ascensor_init()
	_pasillo_sur_init()
	_control_room_init()


func _capsulas_room_init() -> void:
	$CapsulasRoom.connect_exit_unlocked("pasillo", $PasilloNorte, "capsulas")
	$CapsulasRoom.connect_exit_unlocked("sala", $MultiusoRoom, "capsulas")

func _pasillo_norte_init() -> void:
	$PasilloNorte.connect_exit_unlocked("enfermeria", $EnfermeriaRoom, "pasillo")
	$PasilloNorte.connect_exit_unlocked("comunicaciones", $ComunicacionesRoom, "pasillo")

func _pasillo_central_init() -> void:
	$PasilloCentral.connect_exit_unlocked("pasillo_norte", $PasilloNorte, "pasillo_central")
	$PasilloCentral.connect_exit_unlocked("ascensor", $Ascensor, "pasillo")
	$PasilloCentral.connect_exit_unlocked("torretas", $TorretasRoom, "pasillo_central")
	

func _ascensor_init() -> void:
	$Ascensor.connect_exit_unlocked("arriba", get_parent().get_node("Level1").get_node("Ascensor1"))

func _pasillo_sur_init() -> void:
	$PasilloSur.connect_exit_unlocked("torretas", $TorretasRoom, "pasillo_sur")
	$PasilloSur.connect_exit_unlocked("celdas", $CeldasRoom, "pasillo")
	$PasilloSur.connect_exit_unlocked("seguridad", $SeguridadRoom, "pasillo")
	

func _control_room_init() -> void:
	$ControlRoom.connect_exit_unlocked("seguridad", $SeguridadRoom, "control")
	$ControlRoom.connect_exit_unlocked("exclusa", $Exclusa, "control")
	
	

