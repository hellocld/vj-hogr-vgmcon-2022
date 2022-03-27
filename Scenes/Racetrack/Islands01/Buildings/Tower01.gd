extends Spatial

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("controller_c"):
		$AnimationPlayer.stop(true)
		$AnimationPlayer.play("Pulser")
