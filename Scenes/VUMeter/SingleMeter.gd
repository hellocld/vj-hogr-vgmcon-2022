extends Control


onready var bar := $ColorRect


export(int) var index := 0


func _process(delta):
	var mag = SpectrumAnalyzer.get_sample(index)
	bar.margin_top = -mag * self.rect_size.y
