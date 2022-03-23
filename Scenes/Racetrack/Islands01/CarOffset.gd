extends Label

export(NodePath) var carPath
var _car

func _ready() -> void:
	_car = get_node(carPath) as PathFollow

func _process(delta: float) -> void:
	text = "%f" % _car.offset
