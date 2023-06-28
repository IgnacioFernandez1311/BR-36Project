extends Control

onready var animator: AnimationPlayer = get_node("AnimationPlayer")
onready var splash_audio: AudioStreamPlayer = $SplashAudio


func _ready() -> void:
	animator.play("Splash")
	BackgroundMusic.playing = false
	splash_audio.playing = Database.Global_data.sfx
	yield(animator,"animation_finished")
	SceneTransition.change_scene("res://Scenes/MainMenu.tscn", "dissolve")
	
