extends Node

var _rng : RandomNumberGenerator


func _ready() -> void:
	_rng = RandomNumberGenerator.new()


func get_random_sample_idx() -> int:
	return _rng.randi_range(0, 16)


func get_random_hue() -> float:
	return _rng.randf_range(0.0, 1.0)
