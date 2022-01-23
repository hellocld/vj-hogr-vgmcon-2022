extends MeshInstance

export(int) var sample_idx := 0

var _min_db := 60

func _process(_delta: float) -> void:
	var mag = SpectrumAnalyzer.get_sample(sample_idx).length()
	var _scale = clamp((_min_db + linear2db(mag)) / _min_db, 0, 1)
	scale.x = _scale
	scale.y = _scale
