extends Line2D


func _ready() -> void:
	for i in range(16):
		add_point(Vector2(i/15.0 * 480, 0))


func _process(_delta) -> void:
	for i in range(16):
		var y = (SpectrumAnalyzer.get_sample(i) * 270)
		var x = get_point_position(i).x
		set_point_position(i, Vector2(x, y))
