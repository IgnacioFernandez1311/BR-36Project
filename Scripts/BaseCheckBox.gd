class_name GenericCheckBox extends CheckBox

onready var cursor: Cursor = get_node("Cursor")
onready var audio_player: AudioStreamPlayer = get_node("AudioPlayer")
onready var navigate_player: AudioStreamPlayer = get_node("NavigatePlayer")

func _on_CheckBox_mouse_entered() -> void:
	grab_focus()

func _on_BaseCheckBox_focus_entered() -> void:
	cursor.visible = true
	navigate_player.playing = Database.Global_data.sfx

func _on_BaseCheckBox_focus_exited() -> void:
	cursor.visible = false

func _on_BaseCheckBox_pressed() -> void:
	audio_player.playing = Database.Global_data.sfx
