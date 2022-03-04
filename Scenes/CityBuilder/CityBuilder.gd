extends Spatial


export(Resource) var tiles

var _strip_size := 1

enum dirs {
	north = 0b1000,
	south = 0b0010,
	east = 0b0100,
	west = 0b0001
}

# An array of arrays of tiles (a single column of CityTile objects)
var tile_strips : Array


func _ready() -> void:
	for i in range(0, 5):
		_create_new_strip()
	# Instance tiles
	for x in range(0, tile_strips.size()):
		for y in range(0, _strip_size):
			var tile_scene = tiles.get_random_tile(tile_strips[x][y]) as PackedScene
			var tile = tile_scene.instance()
			tile.transform.origin = Vector3(x * 2.1, 0, y * 2.1)
			add_child(tile)
	print("done")


# Creates a new strip of CityTiles, respsecting existing tile neighbors, and adds them to the 
# tile_strips array
func _create_new_strip() -> void:
	var new_strip : Array
	var last_strip = tile_strips.back()
	for t in _strip_size:
		var options = _get_tile_configurations(t, last_strip, new_strip)
		options.shuffle()
		new_strip.append(options.pop_front())
	tile_strips.append(new_strip)


# Creates a collection of possible tile configurations based on the existing tiles
func _get_tile_configurations(var col_idx, var last_strip, var new_strip) -> Array:
	var all_options = _create_total_option_array()
	# if this is the first tile in the first strip, we're done!
	if col_idx == 0 && !is_instance_valid(last_strip):
		return all_options
	var final_options : Array
	# If this is the very first column, we only care about the tile beneath this one
	if(!is_instance_valid(last_strip)):
		for t in all_options:
			var potential_north = (t & 0b1000) == 0b1000
			var existing_south = (new_strip[col_idx - 1] & 0b0010) == 0b0010
			if potential_north == existing_south:
				final_options.append(t)
		return final_options
	# If this is a new column, it gets complicated
	# The first tile only cares about the tile to it's left
	if(col_idx == 0):
		for t in all_options:
			var potential_west = (t & 0b0001) == 0b0001
			var existing_east = (last_strip[col_idx] & 0b0100) == 0b0100
			if  potential_west == existing_east:
				final_options.append(t)
		return final_options
	# Check for matches both to the west and south of this new tile
	for t in all_options:
		var potential_north = (t & 0b1000) == 0b1000
		var existing_south = (new_strip[col_idx - 1] & 0b0010) == 0b0010
		var potential_west = (t & 0b0001) == 0b0001
		var existing_east = (last_strip[col_idx] & 0b0100) == 0b0100
		if potential_north == existing_south && potential_west == existing_east:
			final_options.append(t)
	return final_options


func _create_total_option_array() -> Array:
	var options : Array
	#                        NESW
	options.append(0b0000) # .... 0
	options.append(0b0001) # ...W 1
	options.append(0b0010) # ..S. 2
	options.append(0b0011) # ..SW 3
	options.append(0b0100) # .E.. 4
	options.append(0b0101) # .E.W 5
	options.append(0b0110) # .ES. 6
	options.append(0b0111) # .ESW 7
	options.append(0b1000) # N... 8
	options.append(0b1001) # N..W 9
	options.append(0b1010) # N.S. 10
	options.append(0b1011) # N.SW 11
	options.append(0b1100) # NE.. 12 
	options.append(0b1101) # NE.W 13
	options.append(0b1110) # NES. 14
	options.append(0b1111) # NESW 15
	return options

