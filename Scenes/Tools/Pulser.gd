class_name Pulser
extends Spatial

export(int) var channel
export(float) var multiplier
export(float) var base_scale


func _process(_delta) -> void:
	scale = Vector3.ONE * base_scale + Vector3.ONE * SpectrumAnalyzer.get_sample(channel) * multiplier
