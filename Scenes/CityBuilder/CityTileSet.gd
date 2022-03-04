class_name CityTileSet
extends Resource


export(Array, PackedScene) var N  # 0b1000
export(Array, PackedScene) var E  # 0b0100
export(Array, PackedScene) var S  # 0b0010
export(Array, PackedScene) var W  # 0b0001
export(Array, PackedScene) var NE # 0b1100
export(Array, PackedScene) var ES # 0b0110
export(Array, PackedScene) var SW # 0b0011
export(Array, PackedScene) var WN # 0b1001
export(Array, PackedScene) var NES # 0b1110
export(Array, PackedScene) var ESW # 0b0111
export(Array, PackedScene) var NSW # 0b1011
export(Array, PackedScene) var NEW # 0b1101
export(Array, PackedScene) var NS # 0b1010
export(Array, PackedScene) var EW # 0b0101
export(Array, PackedScene) var NESW # 0b1111
export(Array, PackedScene) var Blank # 0b0000


var _rng : RandomNumberGenerator


func get_random_tile(var flags) -> PackedScene:
	_rng = RandomNumberGenerator.new()
	match flags:
		0b1000:
			return N[_rng.randi_range(0, N.size() - 1)]
		0b0100:
			return E[_rng.randi_range(0, E.size() - 1)]
		0b0010:
			return S[_rng.randi_range(0, S.size() - 1)]
		0b0001:
			return W[_rng.randi_range(0, W.size() - 1)]
		0b1100:
			return NE[_rng.randi_range(0, NE.size() - 1)]
		0b0110:
			return ES[_rng.randi_range(0, ES.size() - 1)]
		0b0011:
			return SW[_rng.randi_range(0, SW.size() - 1)]
		0b1001:
			return WN[_rng.randi_range(0, WN.size() - 1)]
		0b1110:
			return NES[_rng.randi_range(0, NES.size() - 1)]
		0b0111:
			return ESW[_rng.randi_range(0, ESW.size() - 1)]
		0b1011:
			return NSW[_rng.randi_range(0, NSW.size() - 1)]
		0b1101:
			return NEW[_rng.randi_range(0, NEW.size() - 1)]
		0b1010:
			return NS[_rng.randi_range(0, NS.size() - 1)]
		0b0101:
			return EW[_rng.randi_range(0, EW.size() - 1)]
		0b1111:
			return NESW[_rng.randi_range(0, NESW.size() - 1)]
		_:
			return Blank[_rng.randi_range(0, Blank.size() - 1)]
