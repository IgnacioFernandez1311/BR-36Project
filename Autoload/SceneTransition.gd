extends CanvasLayer

onready var animator: AnimationPlayer = get_node("AnimationPlayer")

func _ready() -> void:
	yield(Database, "ready")
	get_node("VHSShaderEffect").visible = Database.Global_data.shader_effect

func change_scene(target_scene: String) -> void:
	animator.play("dissolve")
	yield(animator,"animation_finished")
	get_tree().call_deferred("change_scene", target_scene)
	animator.play_backwards("dissolve")

func quit(transition_type: String) -> void:
	animator.play(transition_type)
	yield(animator,"animation_finished")
	get_tree().quit()
