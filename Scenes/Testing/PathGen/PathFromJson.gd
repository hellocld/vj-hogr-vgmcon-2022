tool
extends Path

export(String) var json setget set_json
export(bool) var loop setget set_loop
var data


func set_json(new_json):
	json = new_json
	var result = JSON.parse(new_json)
	if not result:
		curve.clear_points()
		return
	data = result.get_result()
	curve = Curve3D.new()
	for point in data:
		var pos = Vector3(point["position"]["x"], point["position"]["y"], point["position"]["z"])
		var in_pos = Vector3(point["in"]["x"] - point["position"]["x"], point["in"]["y"] - point["position"]["y"], point["in"]["z"] - point["position"]["z"])
		var out_pos = Vector3(point["out"]["x"] - point["position"]["x"], point["out"]["y"] - point["position"]["y"], point["out"]["z"] - point["position"]["z"])
		curve.add_point(pos, in_pos, out_pos)


func set_loop(new_loop):
	loop = new_loop
	if loop and curve.get_point_count() > 1:
		var pos = curve.get_point_position(0)
		var in_pos = curve.get_point_in(0)
		var out_pos = curve.get_point_out(0)
		curve.add_point(pos, in_pos, out_pos)
	if not loop and curve.get_point_count() > 1:
		curve.remove_point(curve.get_point_count() - 1)
