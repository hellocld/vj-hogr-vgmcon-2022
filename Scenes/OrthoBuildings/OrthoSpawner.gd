extends Spatial

export(Array, PackedScene) var tileset : Array
export(float) var tile_speed := 2.0
export(float) var dist_to_spawn := 2.4

onready var despawn := $Despawn

func _ready() -> void:
	call_deferred("spawn_tile")


func spawn_tile() -> void:
	tileset.shuffle()
	var t_scn = tileset.front()
	var t = t_scn.instance() as OrthoTile
	
	t.speed = tile_speed
	t.dist_to_spawn = dist_to_spawn
	t.despawn_x = despawn.global_transform.origin.x
	t.connect("ready_to_spawn", self, "spawn_tile")
	
	add_child(t)
	t.global_transform.origin = global_transform.origin

