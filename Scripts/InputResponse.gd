class_name InputResponse extends VBoxContainer

onready var input_history: Label = $InputHistory
onready var response_label: ResponseLabel = $Response

func set_text(input_response: String, input: String = "") -> void:
	if input == "":
		input_history.queue_free()
	else:
		input_history.text = " > " + input
	response_label.bbcode_text = input_response

