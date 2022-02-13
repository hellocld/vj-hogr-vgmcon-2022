extends Spatial

export(int) var spectrum_index
export(float) var turn_speed := 1.0
export(float) var turn_time := 0.5

var _mat : ShaderMaterial
var _turn_timer := 0
var _is_turning := false

onready var _mesh := $Disc


func _ready() -> void:
	_mat = _mesh.get_active_material(0)
	#SpectrumAnalyzer.connect("sample_triggered", self, "_on_signal_active")


func _process(delta) -> void:
	_mesh.rotate(Vector3.UP, delta * SpectrumAnalyzer.get_normalized_sample(spectrum_index))
	_mat.set_shader_param("RotY", (_mesh.rotation_degrees.y as float) / 360.0)
	"""
	if _is_turning:
		_mesh.rotate(Vector3.UP, delta * turn_speed)
		_mat.set_shader_param("RotY", _mesh.rotation.y)
		_turn_timer += delta
		if _turn_timer >= turn_time:
			_is_turning = false
			_turn_timer = 0
	"""



func _on_signal_active(idx) -> void:
	if idx != spectrum_index:
		return
	if !_is_turning:
		_is_turning = true
