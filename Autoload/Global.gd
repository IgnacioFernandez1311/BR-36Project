extends Node

var fullscreen : bool
var music : bool
var shader_effect : bool

func _ready() -> void:
	OS.set_window_always_on_top(true)

func _process(_delta: float) -> void:
	shader_effect = Database.Global_data.shader_effect
	music = Database.Global_data.music
	fullscreen = Database.Global_data.fullscreen
	OS.window_fullscreen = fullscreen
	Database.Global_data.shader_effect = shader_effect
