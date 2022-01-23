extends Spatial

export(int) var index := 0
export(float) var threshold := 0.6

onready var _anim_tree := $AnimationTree
var _statemachine : AnimationNodeStateMachinePlayback

func _ready() -> void:
	_statemachine = _anim_tree["parameters/playback"]


func _process(_delta) -> void:
	if SpectrumAnalyzer.get_sample(index) > threshold:
		_statemachine.travel("Vibra")
	else:
		_statemachine.travel("Idle")
