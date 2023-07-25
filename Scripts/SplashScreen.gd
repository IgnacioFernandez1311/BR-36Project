extends Control

onready var animator: AnimationPlayer = get_node("AnimationPlayer")

var some: int = 75

func _ready() -> void:
	OS.window_fullscreen = Database.Global_data.fullscreen
	animator.play("Splash")
	BackgroundMusic.playing = Database.Global_data.music
	yield(animator,"animation_finished")
	SceneTransition.change_scene("res://Scenes/MainMenu.tscn")
	
