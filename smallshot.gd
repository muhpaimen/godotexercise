extends Area2D

@export var speed: int = 600

func _physics_process(delta: float) -> void:
	position += transform.x * delta * speed

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemies"):
		body.hit()
		queue_free()
	if body.is_in_group("wallnemy"):
		queue_free()
	if body is StaticBody2D:
		queue_free()
