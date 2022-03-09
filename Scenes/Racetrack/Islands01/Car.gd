extends PathFollow

export(float) var speed = 3.0
export(NodePath) var look_target

onready var _mesh := $MeshInstance

var _target : Spatial

func _ready() -> void:
	_target = get_node(look_target) as Spatial

func _process(delta: float) -> void:
	offset += (delta * speed)
	_mesh.look_at(_target.global_transform.origin, Vector3.UP)
