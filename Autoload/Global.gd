extends Node

var fullscreen : bool
var glow : bool
var music : bool

func _ready() -> void:
	OS.set_window_always_on_top(true)

func _process(_delta: float) -> void:
	music = SaveControl.data.music
	fullscreen = SaveControl.data.fullscreen
	glow = SaveControl.data.glow
	MainEnv.environment.glow_enabled = glow
	OS.window_fullscreen = fullscreen
