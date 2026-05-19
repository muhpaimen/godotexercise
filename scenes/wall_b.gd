extends RigidBody2D

func destroy():
	queue_free()

func _on_node_2d_movenow(vel: Vector2, speed: Variant) -> void:
	freeze = false
	linear_velocity = vel * speed
	gravity_scale = 0

func _on_node_2d_falldown(bspos: Vector2, exp_force: float) -> void:
	gravity_scale = 1.0
	var bsdir = (global_position - bspos).normalized()
	var expimp = bsdir * exp_force
	apply_central_impulse(expimp)
