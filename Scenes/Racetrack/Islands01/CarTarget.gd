extends PathFollow

export(NodePath) var Car

var _speed := 0.0


func _ready() -> void:
	var car = get_node(Car) as PathFollow
	offset = car.offset + 1
	_speed = car.speed


func _process(delta: float) -> void:
	offset += (delta * _speed)
