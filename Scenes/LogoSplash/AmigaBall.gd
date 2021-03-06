extends RigidBody2D

var _idx = 0
var _mat : ShaderMaterial


func _ready() -> void:
	_mat = $AnimatedSprite.material as ShaderMaterial
	_mat.set_shader_param("Bump", false)

	var dir = 50
	if rand_range(0, 1) < 0.5:
		dir *= -1
	# Set a random x-axis velocity
	apply_impulse(Vector2.ZERO, Vector2(dir, 50))
	_idx = rand_range(0, 15)

func _process(_delta) -> void:
	_mat.set_shader_param("Hue", SpectrumAnalyzer.get_sample(_idx))


func _on_LifeSpan_timeout() -> void:
	$AnimationPlayer.play("Shrink")



func _on_AmigaBall_body_entered(body: Node) -> void:
	_mat.set_shader_param("Bump", true)


func _on_AmigaBall_body_exited(body: Node) -> void:
	_mat.set_shader_param("Bump", false)
