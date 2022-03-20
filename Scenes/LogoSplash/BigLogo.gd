extends Sprite


onready var _animtree = $AnimationTree
var _tree : AnimationNodeStateMachinePlayback
var _y_pos : float

func _ready() -> void:
	_tree = $AnimationTree["parameters/playback"]
	_y_pos = position.y

func _process(_delta) -> void:
	position.y = _y_pos + (sin(_delta) * 10)
	if Input.is_action_just_pressed("HoGR Logo"):
		match _tree.get_current_node():
			"RESET":
				_tree.travel("Unfurl")
			"Unfurl":
				_tree.travel("Glint")
			"Glint":
				_tree.travel("Furl")
			"Furl":
				_tree.travel("Unfurl")
