extends Node

var _base_mat : SpatialMaterial
var _base_mat_path := ""
var _mat_set : Array
var _hue_set : Array
var _num_mats = 16


func _ready() -> void:
	_base_mat = preload("res://Models/Racetrack/Islands01/Buildings/Highlight.material") as SpatialMaterial
	for i in _num_mats:
		_mat_set.append(_base_mat.duplicate())
		_hue_set.append(0.0)
	get_tree().connect("node_added", self, "configure_highlight_material")


func _process(delta: float) -> void:
	for i in _num_mats:
		_hue_set[i] += SpectrumAnalyzer.get_sample(i) * delta
		if _hue_set[i] > 1.0:
			_hue_set[i] = 0.0
		var color = Color.from_hsv(_hue_set[i], 1, 1, 1)
		_mat_set[i].albedo_color = color
		_mat_set[i].emission = color



func configure_highlight_material(node:Node) -> void:
	if node.is_in_group("Highlightable"):
		var idx = randi() % _num_mats
		for child in node.get_children():
			if child is MeshInstance:
				for mat_idx in range(0, child.mesh.get_surface_count()):
					var mat = child.mesh.surface_get_material(mat_idx) as SpatialMaterial
					if mat.resource_name == "Highlight":
						child.mesh.surface_set_material(mat_idx, _mat_set[idx])
