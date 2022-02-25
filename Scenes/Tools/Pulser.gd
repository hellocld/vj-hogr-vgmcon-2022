class_name Pulser
extends Spatial

export(int) var channel
export(Vector3) var multiplier
export(Vector3) var base_scale := Vector3.ONE


func _process(_delta) -> void:
	scale = Vector3.ONE * base_scale + Vector3.ONE * SpectrumAnalyzer.get_sample(channel) * multiplier
