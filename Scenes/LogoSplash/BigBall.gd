extends AnimatedSprite


var _tree : AnimationNodeStateMachinePlayback

func _ready() -> void:
	_tree = $AnimationTree["parameters/playback"]


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("controller_y"):
		match _tree.get_current_node():
			"Reset":
				_tree.travel("FadeIn")
			"FadeIn":
				_tree.travel("FadeOut")
			"FadeOut":
				_tree.travel("FadeIn")
