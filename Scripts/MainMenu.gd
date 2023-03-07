extends Control

const CURSOR_CORRECTION : Vector2 = Vector2(55,18)

onready var buttons : PoolVector2Array = [
	$MainMenuMargin/Rows/ButtonsMargin/Buttons/Play.rect_position,
	$MainMenuMargin/Rows/ButtonsMargin/Buttons/Options.rect_position,
	$MainMenuMargin/Rows/ButtonsMargin/Buttons/Quit.rect_position
	]
onready var buttons_idx : Array = $MainMenuMargin/Rows/ButtonsMargin/Buttons.get_children()
onready var cursor_animator : AnimationPlayer = $MainMenuMargin/Rows/ButtonsMargin/CursorAnimation
var buttons_counter : int = 0

func _ready() -> void:
	$AnimationPlayer.play("write")
	cursor_animator.play("cursor_move")
	yield($AnimationPlayer,"animation_finished")
	$AnimationPlayer.play("blink")
	

func _process(_delta: float) -> void:
	process_input_value()
	process_input()


func _on_Play_pressed() -> void:
	SceneTransition.change_scene("res://Scenes/Main.tscn", "dissolve")

func _on_Options_pressed() -> void:
	SceneTransition.change_scene("res://Scenes/OptionsMenu.tscn", "dissolve")

func _on_Quit_pressed() -> void:
	SceneTransition.quit("dissolve")

func process_input() -> void:
	$MainMenuMargin/Rows/ButtonsMargin/Cursor.position = buttons[buttons_counter] + CURSOR_CORRECTION
	
	if Input.is_action_just_pressed("ui_accept"):
		buttons_idx[buttons_counter].emit_signal("pressed")

func process_input_value() -> void:
	var input_value : int = int(Input.is_action_just_pressed("ui_down")) - int(Input.is_action_just_pressed("ui_up"))
	var last_button : int = buttons_idx.size() - 1
	
	buttons_counter += input_value
	
	if buttons_counter < 0:
		buttons_counter = last_button
	elif buttons_counter > last_button:
		buttons_counter = 0


func _on_Play_mouse_entered() -> void:
	buttons_counter = 0


func _on_Options_mouse_entered() -> void:
	buttons_counter = 1


func _on_Quit_mouse_entered() -> void:
	buttons_counter = 2

