extends Node2D

@onready var enemy = preload("res://scenes/spawn.tscn")
@onready var kamikazenemy = preload("res://kamikaze.tscn")
@onready var wallnemy = preload("res://scenes/wallnemy.tscn")
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

func wallspawn(offset: Vector2 = Vector2.ZERO):
	var newWall = wallnemy.instantiate()
	add_child(newWall)
	newWall.global_position = spawnpoint.global_position + offset

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
	await $Timer.timeout
	kkspawn()
	$Timer.start(0.5)
	await $Timer.timeout
	kkspawn(Vector2(0, 90))
	kkspawn(Vector2(0, -90))
	await intval(3)
	wallspawn()
	await intval(2)
	wallspawn()

func intval(dura: float):
	$Timer.start(dura)
	await $Timer.timeout

func _on_canvas_layer_startgame() -> void:
	$Timer.start(4.0)
	await $Timer.timeout
	spawner()
