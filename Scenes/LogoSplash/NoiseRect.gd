extends TextureRect


var rot := 0.0

func _process(_delta) -> void:
	rot += _delta
	if rot >= 360:
		rot = 0
	set_rotation(deg2rad(rot))
	
