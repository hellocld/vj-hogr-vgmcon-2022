extends Node

signal sample_triggered(idx)
signal sample_detriggered(idx)
signal sample_threshold_changed(idx, val)

var _bus_idx : int
var _effect : AudioEffectSpectrumAnalyzerInstance
var _freq_range := 44100.0 / 4
var _min_db := 60
var _peak_timer_time := 5.0
var _peak_decrease_multiplier = 0.5
var _smooth_sample_range = 16

var _sample_timer : Timer
var _peaks_timers : Array
var _peaks_descend : Array

var sample_size := 16
var samples : Array
var peaks : Array
var smooth_samples : Array
var sample_trigger_thresholds : Array
var sample_triggered : Array



func _ready() -> void:
	_bus_idx = AudioServer.get_bus_index("Input")
	_effect = AudioServer.get_bus_effect_instance(_bus_idx, 0)
	for i in sample_size:
		sample_trigger_thresholds.append(0.5)
		sample_triggered.append(false)
		peaks.append(0.0)
		_peaks_descend.append(true)
		_peaks_timers.append(null)
		


func _process(delta) -> void:
	samples = _get_samples()
	smooth_samples.append(samples.duplicate())
	if smooth_samples.size() > _smooth_sample_range:
		smooth_samples.pop_front()
	_set_peaks()
	_descend_peaks(delta)
	for i in sample_size:
		if samples[i] >= sample_trigger_thresholds[i] && !sample_triggered[i]:
			emit_signal("sample_triggered", i)
			sample_triggered[i] = true
		if samples[i] < sample_trigger_thresholds[i] && sample_triggered[i]:
			emit_signal("sample_detriggered", i)
			sample_triggered[i] = false




# Acquires all samples from the audio bus and returns the normalized values
func _get_samples() -> Array:
	var set:Array
	var freq_subrange = _freq_range / (sample_size + 1)
	for i in sample_size:
		var mag = _effect.get_magnitude_for_frequency_range(i * freq_subrange, (i + 1) * freq_subrange, AudioEffectSpectrumAnalyzerInstance.MAGNITUDE_MAX).length()
		var vol = clamp((_min_db + linear2db(mag)) / _min_db, 0, 1)
		set.append(vol)
	return set


# Returns the current value for the sample at the provided index
func get_sample(idx:int) -> float:
	if idx < samples.size():
		if samples[idx] != null:
			return samples[idx]
	return 0.0


func get_peak(idx:int) -> float:
	if idx < peaks.size():
		if peaks[idx] != null:
			return peaks[idx]
	return 0.0


func get_smooth_sample(idx:int) -> float:
	var x = 0.0
	if idx < sample_size:
		for i in smooth_samples:
			x += i[idx]
		x /= smooth_samples.size()
	return x


func get_normalized_sample(idx:int) -> float:
	if idx < samples.size() and idx < peaks.size():
		if samples[idx] != null and peaks[idx] != null:
			if peaks[idx] > 0.0:
				return clamp(samples[idx] / peaks[idx], 0.0, 1.0)
	return 0.0


# Sets the threshold value at which the 'sample_triggered' signal should be 
# emitted for the given sample index
func set_sample_trigger_threshold(idx:int, val:float) -> void:
	sample_trigger_thresholds[idx] = clamp(val, 0, 1)
	emit_signal("sample_threshold_changed", idx, val)


# Sets the peak value for each sample index
func _set_peaks() -> void:
	for i in sample_size:
		if samples[i] > peaks[i]:
			peaks[i] = samples[i]
			_peaks_descend[i] = false
			_peaks_timers[i] = get_tree().create_timer(_peak_timer_time)
			_peaks_timers[i].connect("timeout", self, "_trigger_peak_descend", [i])
			


func _trigger_peak_descend(i) -> void:
	_peaks_descend[i] = true
	_peaks_timers[i] = null


func _descend_peaks(delta) -> void:
	for i in sample_size:
		if _peaks_descend[i] and peaks[i] > samples[i]:
			peaks[i] -= delta * _peak_decrease_multiplier
