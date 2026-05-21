extends Area2D

@export var speed: int = 500

func _physics_process(delta: float) -> void:
	position += transform.y * delta * speed

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("windstop"):
		speed = 0
		print("aiaiaiaiisoansaonsan")
