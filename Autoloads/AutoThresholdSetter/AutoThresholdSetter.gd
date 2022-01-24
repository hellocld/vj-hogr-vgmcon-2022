extends Node

var _is_sampling := false
var _sample_set : Array
var _num_samples := 0

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("util_autothreshset"):
		_is_sampling = true
		_init_sample_set()
	if Input.is_action_just_released("util_autothreshset"):
		_is_sampling = false
		_set_new_thresholds()
	
	if _is_sampling:
		for i in _sample_set.size():
			_sample_set[i] += SpectrumAnalyzer.get_sample(i)
		_num_samples += 1;

"""
Initializes the sample set and gets things ready for collecting threshold
samples.
"""
func _init_sample_set():
	_sample_set.clear()
	for i in SpectrumAnalyzer.sample_size:
		_sample_set.append(0)
	_num_samples = 0

"""
Sets the new threshold values by averaging all the values acquired via
_init_sample_set().
"""
func _set_new_thresholds():
	for i in SpectrumAnalyzer.sample_size:
		_sample_set[i] /= _num_samples
		SpectrumAnalyzer.set_sample_trigger_threshold(i, _sample_set[i])
