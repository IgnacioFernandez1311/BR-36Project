extends PanelContainer

onready var info_label : Label = $MarginContainer/Rows/InfoLabel
onready var room_name : Label = $MarginContainer/Rows/RoomNameLable
onready var room_description : RichTextLabel = $MarginContainer/Rows/RoomDescription
onready var exit_label : RichTextLabel = $MarginContainer/Rows/ExitLabel
onready var npc_label : RichTextLabel = $MarginContainer/Rows/NPCLable
onready var item_label : RichTextLabel = $MarginContainer/Rows/ItemLabel
onready var machine_label : RichTextLabel = $MarginContainer/Rows/MachineLabel

func handle_room_changed(new_room : GameRoom) -> void:
	info_label.text = "Estas en..."
	room_name.text = new_room.room_name
	room_description.bbcode_text = Types.wrap_text(new_room.room_description,Types.COLOR_SPEECH)
	
	var npc_string : String = new_room.get_npc_description()
	if npc_string == "":
		npc_label.hide()
	else:
		npc_label.show()
		npc_label.bbcode_text = npc_string
	var exit_string : String = new_room.get_exit_description()
	if exit_string == "":
		exit_label.hide()
	else:
		exit_label.show()
		exit_label.bbcode_text = exit_string
	var item_string : String = new_room.get_item_description()
	if item_string == "":
		item_label.hide()
	else:
		item_label.show()
		item_label.bbcode_text = item_string
	var machine_string : String = new_room.get_machine_description()
	if machine_string == "":
		machine_label.hide()
	else:
		machine_label.show()
		machine_label.bbcode_text = machine_string
	

func handle_room_updated(current_room : GameRoom) -> void:
	handle_room_changed(current_room)
	
