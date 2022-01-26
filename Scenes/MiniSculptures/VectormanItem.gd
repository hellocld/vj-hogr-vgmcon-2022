extends Spatial

export(int) var base_static_idx := 3

onready var _base := $Base
onready var _orb := $Orb
onready var _spikes := $Orb/Spikes

var _base_mat


func _ready() -> void:
	_base_mat = _base.get_active_material(0)
	SpectrumAnalyzer.connect("sample_triggered", self, "_enable_tv_static")
	#SpectrumAnalyzer.connect("sample_detriggered", self, "_disable_tv_static")

func _process(delta: float) -> void:
	_update_tv_static()
	_update_orb()
	_update_spikes()


func _update_tv_static() -> void:
	_base_mat.set_shader_param("UV_Off", Vector3(rand_range(0, 1), rand_range(0, 1), rand_range(0, 1)))


func _enable_tv_static(idx) -> void:
	if idx == base_static_idx:
		_base_mat.set_shader_param("Enable_Static", !_base_mat.get_shader_param("Enable_Static"))


func _disable_tv_static(idx) -> void:
	if idx == base_static_idx:
		_base_mat.set_shader_param("Enable_Static", false)

func _update_orb() -> void:
	_orb.rotate_y(SpectrumAnalyzer.get_sample(8) * 0.1)
	_orb.translation = Vector3(0, sin(OS.get_system_time_msecs() * 0.002) * 0.3 + 1.6, 0)


func _update_spikes() -> void:
	_spikes.scale = Vector3.ONE * (SpectrumAnalyzer.get_sample(6) + 0.8)
