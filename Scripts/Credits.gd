extends Control

onready var animator: AnimationPlayer = $AnimationPlayer
onready var skip_label: Label = $Skip
onready var margins: MarginContainer = $Margins
var _credits_timer: Timer = Timer.new()
var _skip_timer: Timer = Timer.new()

func _ready() -> void:
	margins.rect_size.x = 1024
	BackgroundMusic.playing = true
	skip_label.modulate = Color.transparent
	_credits_timer.one_shot = true
	_skip_timer.one_shot = true
	animator.play("write")
	var _credits_timer_connected: int = _credits_timer.connect("timeout", self, "_on_credits_timer_timeout")
	var _skip_timer_connected: int = _skip_timer.connect("timeout", self, "_on_skip_timer_timeout")
	add_child(_credits_timer)
	add_child(_skip_timer)
	_credits_timer.start(6)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept") and skip_label.modulate == Color.transparent:
		var tween: SceneTreeTween = get_tree().create_tween()
		var _tween_animation: Tweener = tween.tween_property(skip_label, "modulate", Color.white, 1)
		_skip_timer.start(4)
	if skip_label.modulate == Color.white:
		if event.is_action_pressed("ui_accept"):
			SceneTransition.change_scene("res://Scenes/SplashScreen.tscn")

func _on_credits_timer_timeout() -> void:
	animator.play("credits")

func _on_skip_timer_timeout() -> void:
	var tween: SceneTreeTween = get_tree().create_tween()
	var _tween_animation: Tweener = tween.tween_property(skip_label, "modulate", Color.transparent, 1)

func _on_Animator_animation_finished(anim_name: String) -> void:
	if anim_name == "credits":
		SceneTransition.change_scene("res://Scenes/SplashScreen.tscn")
