extends Node


var cameras : Array
var current_camera_index := 0


func _ready() -> void:
	register_cameras()
	activate_current_camera()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("cam_next"):
		_on_set_next_camera()
	if event.is_action_pressed("cam_prev"):
		_on_set_previous_camera()


func register_cameras() -> void:
	cameras.clear()
	cameras = get_tree().get_nodes_in_group("Cameras")
	if cameras.size() > 0:
		current_camera_index = cameras.find(get_tree().get_nodes_in_group("PrimaryCamera")[0])


func activate_current_camera() -> void:
	if cameras.size() > 0:
		cameras[current_camera_index].make_current()


func _on_set_next_camera() -> void:
	current_camera_index += 1
	if current_camera_index >= cameras.size():
		current_camera_index = 0
	activate_current_camera()


func _on_set_previous_camera() -> void:
	current_camera_index -= 1
	if current_camera_index < 0:
		current_camera_index = cameras.size() - 1
	activate_current_camera()
