extends Control


onready var game_info : PanelContainer = get_node("Background/MarginContainer/Columns/Rows/GameInfo")
onready var command_handler : Node = get_node("CommandHandler")
onready var room_manager : Node = get_node("RoomsManager")
onready var player : Node = get_node("Player")
onready var main_audio : AudioStreamPlayer = get_node("MainAudio")


func _ready() -> void:
	main_audio.playing = Global.music
	var room : NodePath = SaveControl.data.level.room_name
	var level : int = SaveControl.data.level.level_number
	var _room_changed : int = command_handler.connect("room_changed", $Background/MarginContainer/Columns/SidePanel, "handle_room_changed")
	var _room_updated : int = command_handler.connect("room_updated", $Background/MarginContainer/Columns/SidePanel, "handle_room_updated")
	game_info.create_response(Types.wrap_text("Iniciando Sistemas...",Types.COLOR_SYSTEM))
	yield(get_tree().create_timer(2),"timeout")
	var starting_room_response = command_handler.initialize(room_manager.get_child(level).get_node(room), player)
	game_info.create_response(starting_room_response)
	

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().call_deferred("quit")

func _on_Input_text_entered(new_text: String) -> void:
	var response : String = command_handler.handle_command(new_text)
#	if new_text.empty():
#		return
	game_info.create_response_with_input(response, new_text)

