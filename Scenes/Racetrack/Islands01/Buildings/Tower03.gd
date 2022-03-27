extends Spatial


func _ready() -> void:
	$OmniLight.omni_range *= scale.x


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("controller_b"):
		_kaboom()


func _kaboom() -> void:
	if $OmniLight/AnimationPlayer.is_playing() || $Particles.emitting:
		return
	if rand_range(0.0, 1.0) > 0.3:
		return
	$Particles.emitting = true
	$OmniLight/AnimationPlayer.stop(true)
	$OmniLight/AnimationPlayer.play("Flash")
