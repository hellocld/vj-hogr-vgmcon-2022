extends Sprite


onready var _animtree = $AnimationTree
var _tree : AnimationNodeStateMachinePlayback

func _ready() -> void:
	_tree = $AnimationTree["parameters/playback"]


func _process(_delta) -> void:
	if Input.is_action_just_pressed("controller_a"):
		match _tree.get_current_node():
			"RESET":
				_tree.travel("Unfurl")
			"Unfurl":
				_tree.travel("Glint")
			"Glint":
				_tree.travel("Furl")
			"Furl":
				_tree.travel("Unfurl")
