extends Label


func _process(delta: float) -> void:
	text = "%f" % SpectrumAnalyzer.get_sample(0)
