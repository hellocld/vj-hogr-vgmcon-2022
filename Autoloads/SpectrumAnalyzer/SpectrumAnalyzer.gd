extends Node

var _bus_idx : int
var _effect : AudioEffectSpectrumAnalyzerInstance
var _sample_size := 16
var _freq_range := 44100.0 / 4
var _min_db := 60

var samples : Array


func _ready() -> void:
	_bus_idx = AudioServer.get_bus_index("Input")
	_effect = AudioServer.get_bus_effect_instance(_bus_idx, 0)


func _process(_delta) -> void:
	samples = _get_samples()


func _get_samples() -> Array:
	var set:Array
	var freq_subrange = _freq_range / (_sample_size + 1)
	for i in _sample_size:
		var mag = _effect.get_magnitude_for_frequency_range(i * freq_subrange, (i + 1) * freq_subrange, AudioEffectSpectrumAnalyzerInstance.MAGNITUDE_MAX).length()
		var vol = clamp((_min_db + linear2db(mag)) / _min_db, 0, 1)
		set.append(vol)
	return set


func get_sample(idx:int) -> float:
	if idx < samples.size():
		if samples[idx] != null:
			return samples[idx]
	return 0.0
