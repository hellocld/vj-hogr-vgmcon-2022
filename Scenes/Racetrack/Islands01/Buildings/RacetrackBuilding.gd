class_name RacetrackBuilding
extends Spatial

var _rng : RandomNumberGenerator
var _idx := 0
var _highlight_mats : Array

var _hue := 0.0


func _ready() -> void:
	_idx = RNG.get_random_sample_idx()
	_hue = RNG.get_random_hue()
	for child in get_children():
		if child is MeshInstance:
			for mat_idx in range(0, child.mesh.get_surface_count()):
				var mat = child.mesh.surface_get_material(mat_idx) as SpatialMaterial
				if mat.resource_name == "Highlight":
					_highlight_mats.append(mat)


func _process(delta: float) -> void:
	_hue += SpectrumAnalyzer.get_sample(_idx) * delta
	if _hue > 1.0:
		_hue = 0.0
	var color = Color.from_hsv(_hue, 1, 1, 1)
	for mat in _highlight_mats:
		mat.albedo_color = color
		mat.emission = color
