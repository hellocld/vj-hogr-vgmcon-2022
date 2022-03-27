extends PathFollow


export(String) var RingScene
export(NodePath) var carPath
var _car
var _ring

func _ready() -> void:
	_car = get_node(carPath) as PathFollow
	_ring = load(RingScene)


func _process(delta: float) -> void:
	offset = _car.offset + 15


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("controller_x"):
		var r = _ring.instance() as Spatial
		get_tree().get_root().add_child(r)
		r.global_transform = global_transform.looking_at(_car.global_transform.origin, Vector3.UP)
		#r.global_transform = global_transform
