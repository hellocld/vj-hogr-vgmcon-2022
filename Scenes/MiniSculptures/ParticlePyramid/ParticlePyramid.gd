extends Spatial

onready var _anim_tree_node = $AnimationTree
var _anim_tree : AnimationNodeStateMachinePlayback


func _ready() -> void:
	_anim_tree = _anim_tree_node["parameters/playback"] as AnimationNodeStateMachinePlayback

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("controller_b"):
		_anim_tree_node["parameters/conditions/expand"] = !_anim_tree_node["parameters/conditions/expand"]
		_anim_tree_node["parameters/conditions/contract"] = !_anim_tree_node["parameters/conditions/contract"]


func _collapse() -> void:
	_anim_tree_node["parameters/conditions/contract"] = true
	_anim_tree_node["parameters/conditions/expand"] = false


func _expand() -> void:
	_anim_tree_node["parameters/conditions/contract"] = false
	_anim_tree_node["parameters/conditions/expand"] = true
