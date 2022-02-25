class_name LookAtCam
extends Camera


export(NodePath) var target
var _target : Spatial


func _ready() -> void:
	if target:
		_target = get_node(target)


func _process(_delta) -> void:
	if _target:
		look_at(_target.global_transform.origin, Vector3.UP)
