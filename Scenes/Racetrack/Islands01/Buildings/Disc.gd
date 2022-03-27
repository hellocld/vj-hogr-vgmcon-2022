extends Spatial

export(float) var speed = 1.0

func _process(delta: float) -> void:
	if Input.is_action_pressed("controller_a"):
		rotate_z(delta * speed)
