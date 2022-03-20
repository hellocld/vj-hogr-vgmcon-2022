extends Node


export(Array, String) var scene_list : Array

var scene_index := 0
var mod_on := false
var loader
var loaded = false
var next_scene : PackedScene

var _preloaded_scenes : Array

onready var fade_in_out := $FadeInOut/AnimationPlayer
onready var scene_root := $SceneRoot


func _ready() -> void:
	_load_all_scenes()
	_begin_switch_scene()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("scn_mode"):
		mod_on = true
	if event.is_action_released("scn_mode"):
		mod_on = false
	
	if mod_on:
		if event.is_action_pressed("scn_next"):
			_advance_scene(1)
			get_tree().set_input_as_handled()
		if event.is_action_pressed("scn_prev"):
			_advance_scene(-1)
			get_tree().set_input_as_handled()


# Advances the index, triggers the loading of the new scene
func _advance_scene(dir) -> void:
	scene_index -= dir
	if scene_index < 0:
		scene_index = scene_list.size() - 1
	if scene_index >= scene_list.size():
		scene_index = 0
	_begin_switch_scene()


func _load_all_scenes() -> void:
	for s in scene_list:
		var pre = ResourceLoader.load(s)
		_preloaded_scenes.append(pre)


func _begin_switch_scene() -> void:
	fade_in_out.play("FadeOut")


# Once the animation finishes, change all the scene goodies behind the curtain
func _swap_scene_and_fade_in() -> void:
	if scene_root.get_child_count() > 0:
		var child = scene_root.get_child(0)
		child.queue_free()
	yield(get_tree(), "idle_frame")
	var ns = _preloaded_scenes[scene_index].instance()
	scene_root.add_child(ns)
	CameraSwitcher.register_cameras()
	CameraSwitcher.activate_current_camera()
	fade_in_out.play("FadeIn")


func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "FadeOut":
		_swap_scene_and_fade_in()
