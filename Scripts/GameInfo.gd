class_name GameInfo extends PanelContainer

const INPUT_RESPONSE: PackedScene = preload("res://Scenes/InputResponse.tscn")

export(int, 0, 40) var max_lines_remembered: int = 20

onready var scroll: ScrollContainer = get_node("Margin/ScrollContainer")
onready var scrollbar: VScrollBar = scroll.get_v_scrollbar()
onready var history_rows: VBoxContainer = get_node("Margin/ScrollContainer/HistoryRows")
onready var input_area: LineEdit = get_parent().get_node("InputArea/Columns/Input")

var max_scroll_length: float = 0

func _ready() -> void:
	var _scrollbar_value_changed: int = scrollbar.connect("changed", self, "_handle_scrollbar_changed")
	max_scroll_length = scrollbar.max_value
	scrollbar["custom_styles/scroll"] = StyleBoxEmpty.new()
	scrollbar["custom_styles/scroll_focus"] = StyleBoxEmpty.new()

func create_response(response_text: String) -> void:
	var response: InputResponse = INPUT_RESPONSE.instance()
	var response_label: ResponseLabel = response.get_node("Response")
	
	_add_response_to_game(response)
	response.set_text(response_text)
	
	var response_length: float = response_label.text.length()
	var tween_duration: float = response_length / (response_length / 2)
	response_label.handle_text_animation(response_label,response_label.percent_visible, tween_duration, input_area)

func create_response_with_input(response_text: String, input_text: String) -> void:
	var input_response: InputResponse = INPUT_RESPONSE.instance()
	var response_label: ResponseLabel = input_response.get_node("Response") 
	
	_add_response_to_game(input_response)
	input_response.set_text(response_text, input_text.capitalize())
	
	var input_length: float = input_response.get_child(1).text.length()
	var tween_duration: float = input_length / (input_length / .5) if input_length < 30 else input_length / (input_length / 2)
	response_label.handle_text_animation(response_label,response_label.percent_visible, tween_duration, input_area)

func _handle_scrollbar_changed() -> void:
	if max_scroll_length != scrollbar.max_value:
		max_scroll_length = scrollbar.max_value
		scroll.scroll_vertical = max_scroll_length as int

func _delete_history_beyond_limit() -> void:
	if history_rows.get_child_count() > max_lines_remembered:
		var rows_to_forget: int = history_rows.get_child_count() - max_lines_remembered
		for row in range(rows_to_forget):
			history_rows.get_child(row).queue_free()

func _add_response_to_game(response: Control) -> void:
	history_rows.add_child(response)
	$ResponseAudio.playing = true if Database.Global_data.sfx else false
	_delete_history_beyond_limit()

func delete_history() -> void:
	for row in range(history_rows.get_child_count()):
		history_rows.get_child(row).queue_free()
