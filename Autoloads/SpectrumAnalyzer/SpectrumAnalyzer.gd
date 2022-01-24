extends Node

signal sample_triggered(idx)
signal sample_detriggered(idx)
signal sample_threshold_changed(idx, val)

var _bus_idx : int
var _effect : AudioEffectSpectrumAnalyzerInstance
var _sample_size := 16
var _freq_range := 44100.0 / 4
var _min_db := 60

var samples : Array
var sample_trigger_thresholds : Array
var sample_triggered : Array


func _ready() -> void:
	_bus_idx = AudioServer.get_bus_index("Input")
	_effect = AudioServer.get_bus_effect_instance(_bus_idx, 0)
	for i in _sample_size:
		sample_trigger_thresholds.append(0.5)
		sample_triggered.append(false)


func _process(_delta) -> void:
	samples = _get_samples()
	for i in _sample_size:
		if samples[i] >= sample_trigger_thresholds[i] && !sample_triggered[i]:
			emit_signal("sample_triggered", i)
			sample_triggered[i] = true
		if samples[i] < sample_trigger_thresholds[i] && sample_triggered[i]:
			emit_signal("sample_detriggered", i)
			sample_triggered[i] = false

"""
Acquires all samples from the audio bus and returns the normalized values
"""
func _get_samples() -> Array:
	var set:Array
	var freq_subrange = _freq_range / (_sample_size + 1)
	for i in _sample_size:
		var mag = _effect.get_magnitude_for_frequency_range(i * freq_subrange, (i + 1) * freq_subrange, AudioEffectSpectrumAnalyzerInstance.MAGNITUDE_MAX).length()
		var vol = clamp((_min_db + linear2db(mag)) / _min_db, 0, 1)
		set.append(vol)
	return set

"""
Returns the current value for the sample at the provided index
"""
func get_sample(idx:int) -> float:
	if idx < samples.size():
		if samples[idx] != null:
			return samples[idx]
	return 0.0

"""
Sets the threshold value at which the 'sample_triggered' signal should be 
emitted for the given sample index
"""
func set_sample_trigger_threshold(idx:int, val:float) -> void:
	sample_trigger_thresholds[idx] = clamp(val, 0, 1)
	emit_signal("sample_threshold_changed", idx, val)
