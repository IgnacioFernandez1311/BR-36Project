class_name RoomExit extends Resource


var room_1: Node = null setget set_first_room
var room_2: Node = null setget set_second_room
var room_is_locked: bool = false


func get_other_room(current_room: Node) -> Node:
	if current_room == room_1:
		return room_2
	elif current_room == room_2:
		return room_1
	return current_room

func set_first_room(room: Node) -> void:
	room_1 = room

func set_second_room(room: Node) -> void:
	room_2 = room
