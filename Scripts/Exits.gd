class_name RoomExit
extends Resource


var room_1 = null
var room_2 = null
var room_is_locked : bool = false


func get_other_room(current_room):
	if current_room == room_1:
		return room_2
	elif current_room == room_2:
		return room_1
	else:
		printerr("Esta habitacion no esta conectada a esta salida")
		return null
