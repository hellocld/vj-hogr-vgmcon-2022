extends Control

export(int) var index
onready var bar = $ColorRect


func _process(delta):
	var mag = SpectrumAnalyzer.get_peak(index)
	bar.margin_top = self.rect_size.y * -mag
	bar.margin_bottom = bar.margin_top + 5
