class_name GenericButton extends Button

onready var cursor: Cursor = get_node("Cursor")
onready var audio_player: AudioStreamPlayer = get_node("AudioPlayer")
onready var navigate_player: AudioStreamPlayer = get_node("NavigatePlayer")

func _on_BaseButton_mouse_entered() -> void:
	grab_focus()

func _on_BaseButton_focus_entered() -> void:
	cursor.visible = true
	navigate_player.playing = Database.Global_data.sfx

func _on_BaseButton_focus_exited() -> void:
	cursor.visible = false

func _on_BaseButton_pressed() -> void:
	audio_player.playing = Database.Global_data.sfx
