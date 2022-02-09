extends PathFollow

export(float) var speed := 2.0

func _process(delta) -> void:
	offset += delta * speed
