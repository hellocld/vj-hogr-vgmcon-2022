extends Node

var _mod_on = false


func _ready() -> void:
	#OS.window_fullscreen = true
	#Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	#Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	pass

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("opt_mod"):
		_mod_on = true
	if event.is_action_released("opt_mod"):
		_mod_on = false
	if event.is_action_pressed("opt_fullscreen") and _mod_on:
		OS.window_fullscreen = !OS.window_fullscreen
	if event.is_action_pressed("opt_quit") and _mod_on:
		get_tree().quit()
