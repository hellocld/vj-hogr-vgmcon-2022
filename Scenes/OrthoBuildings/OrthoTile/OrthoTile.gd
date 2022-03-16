class_name OrthoTile
extends Spatial

signal ready_to_spawn

var speed := 1.0
var dist_to_spawn := 2.0
var despawn_x := 0.0

var _spawn_triggered : bool
var _spawn_x : float

func _ready() -> void:
	var rot = randi() % 3 * 90
	for child in get_children():
		if child is Spatial:
			child.rotate_y(deg2rad(rot))
	_spawn_x = global_transform.origin.x


func _process(_delta) -> void:
	global_transform.origin.x -= (_delta * speed)
	if !_spawn_triggered:
		if global_transform.origin.x < _spawn_x - dist_to_spawn:
			emit_signal("ready_to_spawn")
			_spawn_triggered = true
	if global_transform.origin.x <= despawn_x:
		self.queue_free()

