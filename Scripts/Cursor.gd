class_name Cursor extends Position2D

onready var animator: AnimationPlayer = get_node("AnimationPlayer")

func _process(_delta: float) -> void:
	if self.visible:
		animator.play("cursor")
	else:
		animator.stop()
