extends Node2D

export(PackedScene) var BallScene : PackedScene
var _ball

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("controller_a"):
		spawn_ball()

func spawn_ball() -> void:
	var ball = BallScene.instance() as RigidBody2D
	ball.position = Vector2(rand_range(64, 512-64), rand_range(-64, 150))
	add_child(ball)
