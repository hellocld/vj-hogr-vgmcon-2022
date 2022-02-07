extends Camera


export(NodePath) var target

var _target : Spatial


func _ready() -> void:
	_target = get_node(target) as Spatial
	


func _process(_delta) -> void:
	look_at(_target.global_transform.origin, Vector3.UP)
