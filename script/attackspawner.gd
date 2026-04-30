extends Node2D

@onready var enemy = preload("res://scenes/spawn.tscn")
@onready var kamikazenemy = preload("res://kamikaze.tscn")
@onready var spawnpoint = $"."
@onready var player = $"../Node2D/NavigationRegion2D/CharacterBody2D"

func spawn(offset: Vector2 = Vector2.ZERO):
	var newEnemy = enemy.instantiate()
	add_child(newEnemy)
	newEnemy.global_position = spawnpoint.global_position + offset

func kkspawn(offset: Vector2 = Vector2.ZERO):
	var newmissile = kamikazenemy.instantiate()
	
	print("Node Name: ", newmissile.name)
	print("Script attached: ", newmissile.get_script())
	
	newmissile.dor.connect(player.iframe)
	add_child(newmissile)
	newmissile.global_position = spawnpoint.global_position + offset

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
	$Timer.start(2)
	kkspawn()
	$Timer.start(0.5)
	await $Timer.timeout
	kkspawn(Vector2(0, 90))
	kkspawn(Vector2(0, -90))

func _ready() -> void:
	$Timer.start(4.0)
	await $Timer.timeout
	spawner()
