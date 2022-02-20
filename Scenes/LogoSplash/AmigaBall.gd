extends RigidBody2D

var _idx = 0

func _ready() -> void:
	var dir = 50
	if rand_range(0, 1) < 0.5:
		dir *= -1
	# Set a random x-axis velocity
	apply_impulse(Vector2.ZERO, Vector2(dir, 50))
	_idx = rand_range(0, 15)

func _process(_delta) -> void:
	modulate.h = SpectrumAnalyzer.get_normalized_sample(_idx)


func _on_LifeSpan_timeout() -> void:
	$AnimationPlayer.play("Shrink")
