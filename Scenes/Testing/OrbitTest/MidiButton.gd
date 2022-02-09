extends Spatial


func on_pressed():
	scale = Vector3.ONE * 0.5

func on_released():
	scale = Vector3.ONE
