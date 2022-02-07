extends Path

export(String) var json
var data

func _ready() -> void:
	var result = JSON.parse(json)
	data = result.get_result()
	curve = Curve3D.new()
	for point in data:
		var pos = Vector3(point["position"]["x"], point["position"]["y"], point["position"]["z"])
		var in_pos = Vector3(point["in"]["x"], point["in"]["y"], point["in"]["z"])
		var out_pos = Vector3(point["out"]["x"], point["out"]["y"], point["out"]["z"])
		curve.add_point(pos, in_pos, out_pos)


