extends Area2D

@export var speed: int = 500

func _physics_process(delta: float) -> void:
	position += transform.x * delta * speed

func _on_body_entered(body):
	if body.is_in_group("enemies"):
		body.hit()
	
	if body is StaticBody2D:
		queue_free()
