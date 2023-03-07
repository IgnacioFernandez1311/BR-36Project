extends Control

const CURSOR_CORRECTION : Vector2 = Vector2(210,212)
const BACK_BUTTON_CURSOR_CORRECTION : Vector2 = Vector2(210, 218)

onready var buttons : PoolVector2Array = [
	$MarginContainer/VBoxContainer/FullScreenCheckBox.rect_position,
	$MarginContainer/VBoxContainer/GlowCheckBox.rect_position,
	$MarginContainer/VBoxContainer/MusicCheckBox.rect_position,
	$MarginContainer/VBoxContainer/BackButton.rect_position
	]
onready var buttons_idx : Array = $MarginContainer/VBoxContainer.get_children()
onready var fullscreen_checkbox : CheckBox = $MarginContainer/VBoxContainer/FullScreenCheckBox
onready var glow_checkbox : CheckBox = $MarginContainer/VBoxContainer/GlowCheckBox
onready var music_checkbox : CheckBox = $MarginContainer/VBoxContainer/MusicCheckBox

var buttons_counter : int = 0

func _ready() -> void:
	fullscreen_checkbox.pressed = SaveControl.data.fullscreen
	glow_checkbox.pressed = MainEnv.environment.glow_enabled
	

func _process(_delta: float) -> void:
	Global.fullscreen = SaveControl.data.fullscreen
	MainEnv.environment.glow_enabled = glow_checkbox.pressed
	$AnimationPlayer.play("cursor")
	process_input_value()
	process_input()


func _on_FullScreenCheckBox_toggled(button_pressed : bool) -> void:
	fullscreen_checkbox.pressed = button_pressed
	SaveControl.data.fullscreen = fullscreen_checkbox.pressed
	SaveControl.save_data()

func _on_BackButton_pressed() -> void:
	SceneTransition.change_scene("res://Scenes/MainMenu.tscn", "dissolve")


func _on_GlowCheckBox_toggled(button_pressed : bool) -> void:
	glow_checkbox.pressed = button_pressed
	SaveControl.data.glow = glow_checkbox.pressed
	SaveControl.save_data()

func _on_MusicCheckBox_toggled(button_pressed: bool) -> void:
	music_checkbox.pressed = button_pressed
	SaveControl.data.music = music_checkbox.pressed
	SaveControl.save_data()


func process_input() -> void:
	$MarginContainer/Cursor.position = buttons[buttons_counter] + CURSOR_CORRECTION if buttons_idx[buttons_counter] is CheckBox else buttons[buttons_counter] + BACK_BUTTON_CURSOR_CORRECTION
	
	if Input.is_action_just_pressed("ui_accept") and buttons_idx[buttons_counter] is CheckBox:
		buttons_idx[buttons_counter].emit_signal("toggled", !buttons_idx[buttons_counter].pressed)
	elif Input.is_action_just_pressed("ui_accept"):
		buttons_idx[buttons_counter].emit_signal("pressed")


func process_input_value() -> void:
	var input_value : int = int(Input.is_action_just_pressed("ui_down")) - int(Input.is_action_just_pressed("ui_up"))
	var last_button : int = buttons_idx.size() - 1
	
	buttons_counter += input_value
	
	if buttons_counter < 0:
		buttons_counter = last_button
	elif buttons_counter > last_button:
		buttons_counter = 0


func _on_FullScreenCheckBox_mouse_entered() -> void:
	buttons_counter = 0

func _on_GlowCheckBox_mouse_entered() -> void:
	buttons_counter = 1

func _on_MusicCheckBox_mouse_entered() -> void:
	buttons_counter = 2

func _on_BackButton_mouse_entered() -> void:
	buttons_counter = 3
