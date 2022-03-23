extends MeshInstance

export(Vector2) var scroll_speed := Vector2(0.02, 0.04)

onready var mat = mesh.surface_get_material(0) as SpatialMaterial


func _process(_delta) -> void:
	mat.uv1_offset += (Vector3(scroll_speed.x, scroll_speed.y, 0) * _delta)
