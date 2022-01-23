extends Spatial


export(Vector3) var scale_factor := Vector3.ONE
export(Vector3) var base_scale := Vector3.ONE
export(int) var index

func _process(_delta) -> void:
	var s = SpectrumAnalyzer.get_sample(index)
	scale = base_scale + scale_factor * s
