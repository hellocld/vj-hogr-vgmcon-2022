extends Spatial

export(int) var idx
export(Curve) var curve:Curve

onready var _mesh = $Bit
var _counter := 1.0
var _last := 0.0
var _target := 1


func _ready() -> void:
	SpectrumAnalyzer.connect("sample_triggered", self, "_on_thresh_hit")


func _process(delta) -> void:
	_counter += delta
	_mesh.set("blend_shapes/Key", lerp(_last, _target, curve.interpolate(_counter)))


func _on_thresh_hit(i):
	if i == idx and _counter >= 1:
		_last = _target
		_target = -_target
		_counter = 0
