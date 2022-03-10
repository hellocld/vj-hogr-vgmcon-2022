extends MeshInstance

export(float) var speed = 1.0

func _process(delta: float) -> void:
	rotate_y(delta * speed)
