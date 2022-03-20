extends ViewportContainer

onready var anim = $Viewport/AnimationPlayer


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Hey"):
		anim.stop()
		anim.play("New Anim")
