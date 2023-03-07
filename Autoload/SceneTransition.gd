extends CanvasLayer

onready var animator : AnimationPlayer = get_node("AnimationPlayer")

func change_scene(target_scene : String, transition_type : String) -> void:
	animator.play(transition_type)
	yield(animator,"animation_finished")
	get_tree().call_deferred("change_scene", target_scene)
	animator.play_backwards(transition_type)

func quit(transition_type : String) -> void:
	animator.play(transition_type)
	yield(animator,"animation_finished")
	get_tree().quit()
