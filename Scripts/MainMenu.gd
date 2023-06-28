extends Control


onready var first_button: Button = $MainMenuMargin/Rows/ButtonsMargin/Buttons/Play

func _ready() -> void:
	BackgroundMusic.playing = Database.Global_data.music
	first_button.grab_focus()
	$AnimationPlayer.play("write")
	yield($AnimationPlayer,"animation_finished")
	$AnimationPlayer.play("blink")

func _on_Play_pressed() -> void:
	SceneTransition.change_scene("res://Scenes/Main.tscn", "dissolve")

func _on_Options_pressed() -> void:
	SceneTransition.change_scene("res://Scenes/OptionsMenu.tscn", "dissolve")

func _on_Quit_pressed() -> void:
	SceneTransition.quit("dissolve")
