extends CharacterBody2D

@export var speed: int = 300
@export var bigshot = 0.4
@export var bulcount = 6
@export var hp = 7:
	set(value):
		hp = value
		print("yeyyeysos")
		if value == 0:
			get_tree().paused = true

@onready var iframetimer = $Timer
@onready var bstimer = $bigshottimer
@onready var box = $"../../NinePatchRect"
@onready var bigbullet = preload("res://scenes/bigshot.tscn")
@onready var smallbullet = preload("res://smallshot.tscn")
@onready var chgtex = preload("res://assets/soulcc.png")
@onready var uctex = preload("res://assets/soul.png")

var invis: bool = false
var holdTimer = 0.0
var trigger = false
var bigTrigger = false

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed
	
func _process(delta: float) -> void:
	if Input.is_action_pressed("shoot"):
		holdTimer += delta
		if holdTimer >= bigshot && !bigTrigger:
			$Sprite2D.charge()
	if Input.is_action_just_released("shoot"):
		if holdTimer >= bigshot && !bigTrigger:
			bigTrigger = true
			bigshoot()
			bstimer.start(0.4)
		elif holdTimer < bigshot && !trigger && bulcount != 0:
			trigger = true
			smallshot()
			bstimer.start(0.09)
			bulcount -= 1
			if bulcount == 0:
				bstimer.start(1.5)
		holdTimer = 0.0
		$Sprite2D.uncharge()

func _physics_process(delta):
	get_input()
	move_and_slide()
	
	var boxmin = box.global_position + Vector2(30, 30)
	var boxmax = box.global_position + box.size + Vector2(306, 290)
	
	global_position.x = clamp(global_position.x, boxmin.x, boxmax.x)
	global_position.y = clamp(global_position.y, boxmin.y,  boxmax.y)
	

func iframe():
	invis = true
	iframetimer.start(1.0)
	
	var tween = create_tween()
	tween.set_loops(5)
	tween.tween_property($Sprite2D,"modulate:a", 0.3, 0.1)
	tween.tween_property($Sprite2D,"modulate:a", 1.0, 0.1)
	hp -= 1

func _on_timer_timeout() -> void:
	$Sprite2D.modulate.a = 1.0
	invis = false


func _on_area_2d_gothit() -> void:
	if (!invis):
		iframe()

func bigshoot():
	var spam97 = bigbullet.instantiate()
	get_parent().add_child(spam97)
	spam97.global_position = $".".global_position
	
func smallshot():
	var tentv = smallbullet.instantiate()
	get_parent().add_child(tentv)
	tentv.global_position = $".".global_position + Vector2(10, 0)
	

func _on_bigshottimer_timeout() -> void:
	bigTrigger = false
	trigger = false
	if bulcount == 0:
		bulcount = 6
