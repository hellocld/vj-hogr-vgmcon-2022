extends Line2D

export(NodePath) var feedback_rect
export(NodePath) var viewport
var _feedback : TextureRect
var _viewport : Viewport
var _last_frame


func _ready() -> void:
	_feedback = get_node(feedback_rect)
	_viewport = get_node(viewport)
	for i in range(32):
		add_point(Vector2((i/31.0 * 480.0/2.0) + (480.0 / 4.0), 0))
		gradient.add_point(i/31.0, Color(1, 1, 1))
	get_tree().connect("idle_frame", self, "_snag_frame")


func _process(_delta) -> void:
	if Input.is_action_just_pressed("controller_x"):
		visible = !visible
	
	_feedback.texture.create_from_image(_last_frame)
	
	for i in range(16):
		var y = 220 - (SpectrumAnalyzer.get_sample(i) * (270/2)) 
		var x_a = get_point_position(i).x
		var x_b = get_point_position(31-i).x
		set_point_position(i, Vector2(x_a, y))
		set_point_position(31-i, Vector2(x_b, y))
		gradient.set_color(i, Color.from_hsv(1 - SpectrumAnalyzer.get_sample(i), 1, 1))
		gradient.set_color(31-i, Color.from_hsv(1 - SpectrumAnalyzer.get_sample(i), 1, 1))


func _snag_frame() -> void:
	_last_frame = _viewport.get_texture().get_data()
	_last_frame.flip_y()

