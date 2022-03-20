extends ViewportContainer

onready var anim = $Viewport/AnimationPlayer
onready var sprite = $Viewport/Sprite

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Hey"):
		sprite.self_modulate = Color.from_hsv(rand_range(0.0, 1.0), 1.0, 1.0, 1.0)
		anim.stop()
		anim.play("New Anim")
