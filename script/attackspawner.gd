extends Node2D

@onready var enemy = preload("res://scenes/spawn.tscn")
@onready var spawnpoint = $"."

func spawn(offset: Vector2 = Vector2.ZERO):
	var newEnemy = enemy.instantiate()
	add_child(newEnemy)
	newEnemy.global_position = spawnpoint.global_position + offset

func spawner() -> void:
	spawn()
	$Timer.start(0.4)
	await $Timer.timeout
	spawn()
	$Timer.start(0.4)
	await  $Timer.timeout
	spawn()
	$Timer.start(1)
	await $Timer.timeout
	spawn(Vector2(0, 40))
	$Timer.start(0.4)
	await $Timer.timeout
	spawn(Vector2(0, 40))
	$Timer.start(0.4)
	await $Timer.timeout
	spawn(Vector2(0, 40))

func _ready() -> void:
	$Timer.start(4.0)
	await $Timer.timeout
	spawner()
