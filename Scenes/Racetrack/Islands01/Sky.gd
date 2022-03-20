extends MeshInstance

onready var mat = mesh.surface_get_material(0) as SpatialMaterial


func _process(_delta) -> void:
	mat.uv1_offset += (Vector3(0.02, 0.04, 0) * _delta)
