extends PathFollow

export(float) var speed := 1.0


func _process(delta: float) -> void:
	offset += delta * speed
