extends Control

export(int) var index := 0

onready var _bar := $ColorRect
onready var _anim := $AnimationPlayer

func _ready() -> void:
	_bar.margin_top = self.rect_size.y * -SpectrumAnalyzer.sample_trigger_thresholds[index]
	_bar.margin_bottom = _bar.margin_top + 5
	SpectrumAnalyzer.connect("sample_threshold_changed", self, "_update_bar_pos")
	SpectrumAnalyzer.connect("sample_triggered", self, "_on_sample_triggered")

"""
Update the position of the threshold bar based on the SpectrumAnalyzer's 
threshold for the given index.
"""
func _update_bar_pos(idx, val) -> void:
	if idx == index:
		_bar.margin_top = self.rect_size.y * -val
		_bar.margin_bottom = _bar.margin_top + 5


func _on_sample_triggered(idx) -> void:
	if idx == index:
		_anim.play("Blink")
