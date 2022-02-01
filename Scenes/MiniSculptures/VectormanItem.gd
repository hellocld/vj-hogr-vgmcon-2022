extends Spatial

export(int) var base_static_idx := 3

onready var _base := $Base
onready var _orb := $Orb
onready var _spikes1 := $Orb/SpikesCenter001/Spikes001
onready var _spikes2 := $Orb/SpikesCenter002/Spikes002
onready var _spikes3 := $Orb/SpikesCenter003/Spikes003

var state_machine : AnimationNodeStateMachinePlayback
var _expand_count := 0

var _base_mat


func _ready() -> void:
	_base_mat = _base.mesh.surface_get_material(0)
	SpectrumAnalyzer.connect("sample_triggered", self, "_enable_tv_static")
	SpectrumAnalyzer.connect("sample_triggered", self, "_toggle_spikes_state")
	#SpectrumAnalyzer.connect("sample_detriggered", self, "_disable_tv_static")
	state_machine = $AnimationTree["parameters/playback"]

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
	_spikes1.scale = Vector3.ONE * (SpectrumAnalyzer.get_sample(6) + 0.8)
	_spikes2.scale = Vector3.ONE * (SpectrumAnalyzer.get_sample(6) + 0.8)
	_spikes3.scale = Vector3.ONE * (SpectrumAnalyzer.get_sample(6) + 0.8)


func _toggle_spikes_state(idx) -> void:
	if idx != 8:
		pass
	_expand_count += 1
	if _expand_count > 256:
		if state_machine.get_current_node() == "Expand":
			state_machine.travel("Collapse")
		else:
			state_machine.travel("Expand")
		_expand_count = 0

