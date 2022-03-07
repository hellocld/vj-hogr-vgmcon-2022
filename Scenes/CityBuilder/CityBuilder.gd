extends Spatial


export(Resource) var tiles

var _strip_size := 1

enum dirs {
	north = 0b1000,
	south = 0b0010,
	east = 0b0100,
	west = 0b0001
}

var tile_map = {}


func _get_tile_options(var pos:Vector2) -> Array:
	var north = tile_map.get(pos + Vector2.UP)
	var south = tile_map.get(pos + Vector2.DOWN)
	var east = tile_map.get(pos + Vector2.RIGHT)
	var west = tile_map.get(pos + Vector2.LEFT)
	
	var options = _create_total_option_array()
	
	for opt in options:
		if north:
			
	
	
	return options


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

