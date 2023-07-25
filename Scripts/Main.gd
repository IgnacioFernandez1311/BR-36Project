extends Control


onready var game_info: PanelContainer = get_node("Background/MarginContainer/Columns/Rows/GameInfo")
onready var room_manager: RoomsManager = get_node("RoomsManager")
onready var command_handler: CommandHandler = get_node("CommandHandler")
var timer: Timer = Timer.new()
var room: NodePath
var level: int


func _ready() -> void:
	timer.one_shot = true
	add_child(timer)
	room = Database.Global_data.level.room_name
	level = Database.Global_data.level.number
	connect_signals()
	game_info.create_response(Types.wrap_text("Iniciando Sistemas...",Types.COLOR_SYSTEM))
	timer.start(2)
	

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().call_deferred("quit")

func _on_Input_text_entered(new_text: String) -> void:
	var response = command_handler.handle_command(new_text)
	if new_text.empty():
		return
	game_info.create_response_with_input(response, new_text)

func _on_start_timer_timeout() -> void:
	create_initial_response(level, room)

func create_initial_response(level_ref: int, room_ref: NodePath) -> void:
	var starting_room_response: String = command_handler.initialize(room_manager.get_child(level_ref).get_node(room_ref))
	game_info.create_response(starting_room_response)

func connect_signals() -> void:
	var _timer_timeout: int = timer.connect("timeout", self, "_on_start_timer_timeout")
	var _room_changed: int = command_handler.connect("room_changed", $Background/MarginContainer/Columns/SidePanel, "handle_room_changed")
	var _room_updated: int = command_handler.connect("room_updated", $Background/MarginContainer/Columns/SidePanel, "handle_room_updated")
