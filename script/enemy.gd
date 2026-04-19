extends CharacterBody2D

@export var speed: int = 200

func _ready() -> void:
	velocity = Vector2(-1, 0) * speed

func _physics_process(delta: float) -> void:
	move_and_slide()

func hit():
	queue_free()
