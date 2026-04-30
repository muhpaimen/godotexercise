extends CharacterBody2D

@export var speed = 400

@onready var navAg = $NavigationAgent2D
@onready var explosion = preload("res://scenes/kaboom.tscn")
@onready var timer = $Timer

signal boom



func _physics_process(delta: float) -> void:
	var player = get_tree().get_first_node_in_group("player")
	navAg.target_position = player.global_position
	var nextPathPos = navAg.get_next_path_position()
	var newVel = global_position.direction_to(nextPathPos) * speed
	
	velocity = newVel
	
	move_and_slide()

func explode():
	var exp = explosion.instantiate()
	exp.duar.connect(emitshit)
	add_child.call_deferred(exp)
	exp.position = Vector2.ZERO
	speed = 0

func hit():
	velocity = Vector2.ZERO
	$CollisionShape2D.set_deferred("disabled", true)
	$hitbox/CollisionPolygon2D.set_deferred("disabled", true)
	explode()
	timer.start(3.0)
	await timer.timeout
	queue_free()

func emitshit():
	boom.emit()
