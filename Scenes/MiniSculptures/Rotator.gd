extends Spatial

export(Vector3) var rotation_amount

func _process(delta: float) -> void:
	rotate_x(rotation_amount.x * delta)
	rotate_y(rotation_amount.y * delta)
	rotate_z(rotation_amount.z * delta)
