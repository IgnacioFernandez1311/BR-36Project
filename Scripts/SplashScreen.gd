extends Control

onready var animator : AnimationPlayer = get_node("AnimationPlayer")

func _ready():
	animator.play("Splash")
	yield(animator,"animation_finished")
	SceneTransition.change_scene("res://Scenes/MainMenu.tscn", "dissolve")
	
