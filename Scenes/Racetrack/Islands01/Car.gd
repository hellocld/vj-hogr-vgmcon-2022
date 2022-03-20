extends PathFollow

export(float) var speed = 3.0
export(NodePath) var look_target

onready var _mesh := $Car
onready var _car_model := $Car/CarImport

var _target : Spatial
var _vert_offset : float
var _sin_count := 0.0

func _ready() -> void:
	_target = get_node(look_target) as Spatial
	_vert_offset = _car_model.transform.origin.y
	unit_offset = rand_range(0.0, 1.0)

func _process(delta: float) -> void:
	_sin_count += delta
	_sin_count = wrapf(_sin_count, 0, TAU)
	
	offset += (delta * speed)
	_mesh.look_at(_target.global_transform.origin, Vector3.UP)
	_car_model.transform.origin.y = (sin(_sin_count) * 0.05) + _vert_offset


