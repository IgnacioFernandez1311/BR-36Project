extends Control

onready var fullscreen_checkbox: CheckBox = $MarginContainer/ButtonsContainer/FullScreenCheckBox
onready var music_checkbox: CheckBox = $MarginContainer/ButtonsContainer/MusicCheckBox
onready var animated_text_checkbox: CheckBox = $MarginContainer/ButtonsContainer/AnimatedTextCheckBox
onready var shader_effect_checkbox: CheckBox = $MarginContainer/ButtonsContainer/VHSEffectCheckBox
onready var sfx_checkbox: CheckBox = $MarginContainer/ButtonsContainer/SFXCheckBox

func _ready() -> void:
	fullscreen_checkbox.grab_focus()
	fullscreen_checkbox.pressed = Database.Global_data.fullscreen
	sfx_checkbox.pressed = Database.Global_data.sfx
	shader_effect_checkbox.pressed = SceneTransition.get_node("VHSShaderEffect").visible 
	animated_text_checkbox.pressed = Database.Global_data.text_anim
	music_checkbox.pressed = Database.Global_data.music
	

func _process(_delta: float) -> void:
	Global.fullscreen = Database.Global_data.fullscreen
	SceneTransition.get_node("VHSShaderEffect").visible = shader_effect_checkbox.pressed


func _on_FullScreenCheckBox_toggled(button_pressed : bool) -> void:
	fullscreen_checkbox.pressed = button_pressed
	Database.Global_data.fullscreen = fullscreen_checkbox.pressed
	Database.save_data()

func _on_BackButton_pressed() -> void:
	SceneTransition.change_scene("res://Scenes/MainMenu.tscn", "dissolve")

func _on_MusicCheckBox_toggled(button_pressed: bool) -> void:
	music_checkbox.pressed = button_pressed
	Database.Global_data.music = music_checkbox.pressed
	BackgroundMusic.playing = Database.Global_data.music
	Database.save_data()

func _on_AnimatedTextCheckBox_toggled(button_pressed: bool) -> void:
	animated_text_checkbox.pressed = button_pressed
	Database.Global_data.text_anim = animated_text_checkbox.pressed
	Database.save_data()
	print(Database.Global_data.text_anim)

func _on_VHSEffect_toggled(button_pressed: bool) -> void:
	shader_effect_checkbox.pressed = button_pressed
	Database.Global_data.shader_effect = shader_effect_checkbox.pressed
	Database.save_data()

func _on_SFXCheckBox_toggled(button_pressed: bool) -> void:
	sfx_checkbox.pressed = button_pressed
	Database.Global_data.sfx = sfx_checkbox.pressed
	Database.save_data()
