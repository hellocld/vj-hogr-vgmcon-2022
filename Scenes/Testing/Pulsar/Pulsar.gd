extends Spatial

export(float) var trigger_val := 0.6
export(int) var index := 0
onready var _anim_player := $AnimationPlayer

func _ready() -> void:
	_anim_player.seek(0)
	_anim_player.play("New Anim")

func _process(_delta) -> void:
	if SpectrumAnalyzer.get_sample(index) > trigger_val:
		_anim_player.seek(0)
		_anim_player.play("New Anim")

