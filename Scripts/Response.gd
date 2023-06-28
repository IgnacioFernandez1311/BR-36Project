class_name ResponseLabel extends RichTextLabel

var animate_text: bool

func _ready() -> void:
	animate_text = Database.Global_data.text_anim
	self.percent_visible = 1.0 if !animate_text else 0.0

func handle_text_animation(tween_object: Node, tween_variation: float, tween_duration: float, input_area: LineEdit) -> void:
	if animate_text:
		input_area.editable = false
		var tween: SceneTreeTween = create_tween()
		var tween_animation: PropertyTweener = tween.tween_property(tween_object,"percent_visible", tween_variation + 1, tween_duration)
		yield(tween_animation,"finished")
		input_area.editable = true

