extends Node

export(Array, NodePath) var anim_nodes : Array

var _anim_nodes : Array
var _rand : RandomNumberGenerator
var _current_idx := 0


func _ready() -> void:
	for a in anim_nodes:
		_anim_nodes.append(get_node(a))
	_rand = RandomNumberGenerator.new()
	_current_idx = _rand.randi_range(0, anim_nodes.size() - 1)
	_anim_nodes[_current_idx].play("Show")

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("controller_x"):
		_change_to_sculpt()


func _change_to_sculpt() -> void:
	_anim_nodes[_current_idx].play("Hide")
	var new_idx = _current_idx
	while new_idx == _current_idx:
		new_idx = _rand.randi_range(0, anim_nodes.size() - 1)
	_current_idx = new_idx
	_anim_nodes[_current_idx].play("Show")
