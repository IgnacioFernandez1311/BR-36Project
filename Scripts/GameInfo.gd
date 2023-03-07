extends PanelContainer

const INPUT_RESPONSE : PackedScene = preload("res://Scenes/InputResponse.tscn")

export(int) var max_lines_remembered : int = 30

onready var scroll : ScrollContainer = get_node("Margin/ScrollContainer")
onready var scrollbar : VScrollBar = scroll.get_v_scrollbar()
onready var history_rows : VBoxContainer = get_node("Margin/ScrollContainer/HistoryRows")

var max_scroll_length : float = 0

func _ready() -> void:
	var _scrollbar_value_changed : int = scrollbar.connect("changed", self, "_handle_scrollbar_changed")
	max_scroll_length = scrollbar.max_value
	scrollbar["custom_styles/scroll"] = StyleBoxEmpty.new()
	scrollbar["custom_styles/scroll_focus"] = StyleBoxEmpty.new()


func create_response(response_text : String) -> void:
	var response : VBoxContainer = INPUT_RESPONSE.instance()
	var input_area : LineEdit = get_parent().get_node("InputArea/Columns/Input")
	input_area.editable = false
	_add_response_to_game(response)
	response.set_text(response_text, "")
	var tween : SceneTreeTween = create_tween()
	var response_label : Node = response.get_child(1)
	var tween_duration : float = response_label.text.length()
	var tween_animation : PropertyTweener = tween.tween_property(response_label,"percent_visible", response_label.percent_visible + 1, tween_duration / (tween_duration / 2))
	yield(tween_animation,"finished")
	input_area.editable = true

func create_response_with_input(response_text : String, input_text : String) -> void:
	var input_response : VBoxContainer = INPUT_RESPONSE.instance()
	var input_area : LineEdit = get_parent().get_node("InputArea/Columns/Input")
	input_area.editable = false
	_add_response_to_game(input_response)
	input_response.set_text(response_text, input_text.capitalize())
	var tween : SceneTreeTween = create_tween()
	var input_length : float = input_response.get_child(1).text.length()
	var tween_duration : float = input_length / (input_length / .5) if input_length < 30 else input_length / (input_length / 2)
	var tween_animation : PropertyTweener = tween.tween_property(input_response.get_child(1),"percent_visible", input_response.get_child(1).percent_visible + 1, tween_duration)
	yield(tween_animation,"finished")
	input_area.editable = true


func _handle_scrollbar_changed() -> void:
	if max_scroll_length != scrollbar.max_value:
		max_scroll_length = scrollbar.max_value
		scroll.scroll_vertical = max_scroll_length as int

func _delete_history_beyond_limit() -> void:
	if history_rows.get_child_count() > max_lines_remembered:
		var rows_to_forget : int = history_rows.get_child_count() - max_lines_remembered
		for row in range(rows_to_forget):
			history_rows.get_child(row).queue_free()


func _add_response_to_game(response : Control) -> void:
	history_rows.add_child(response)
	_delete_history_beyond_limit()
  
