class_name OrthoTile
extends Spatial

signal ready_to_spawn

var spawner : Spatial
var speed := 1.0
var dist_to_spawn := 2.0
var despawn_x := 0.0

var _spawn_triggered : bool


func _ready() -> void:
	var rot = randi() % 3 * 90
	for child in get_children():
		if child is Spatial:
			child.rotate_y(deg2rad(rot))


func _process(_delta) -> void:
	global_transform.origin.x -= (_delta * speed)
	if !_spawn_triggered:
		if global_transform.origin.distance_to(spawner.global_transform.origin) >= dist_to_spawn:
			emit_signal("ready_to_spawn")
			_spawn_triggered = true
	if global_transform.origin.x <= despawn_x:
		self.queue_free()

