extends CharacterBody2D

@export var speed: int = 300
@export var dashspeed: int = 1000
@export var bigshot = 0.4
@export var bulcount = 6
@export var windspeed = 200
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
@onready var trail = preload("res://scenes/trail.tscn")

var invis: bool = false
var holdTimer = 0.0
var trigger = false
var bigTrigger = false
var dialEND = false
var wind: bool = false
var booster = false
var dashdelay = false

var inp_vel = Vector2.ZERO
var ext_vel = Vector2.ZERO

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	if not dashdelay:
		inp_vel = input_direction * speed
	
func _process(delta: float) -> void:
	if Input.is_action_pressed("shoot") and dialEND == true:
		holdTimer += delta
		if holdTimer >= bigshot && !bigTrigger:
			$Sprite2D.charge()
	if Input.is_action_just_released("shoot") and dialEND == true:
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
				bstimer.start(0.7)
		holdTimer = 0.0
		$Sprite2D.uncharge()
	
	if Input.is_action_just_pressed("dash") and booster and not dashdelay:
		var input_direction = Input.get_vector("left", "right", "up", "down")
		var trail2 = dashtrail()
		if input_direction != Vector2.ZERO :
			inp_vel = input_direction * dashspeed
		print("dash dash dash")
		dashdelay = true
		$Timer2.start(0.07)
		await $Timer2.timeout
		dashdelay = false
		trail2.queue_free()

func dashtrail():
	var curpos = global_position
	var trail1 = trail.instantiate()
	get_parent().add_child(trail1)
	trail1.global_position = curpos
	return trail1

func _physics_process(delta):
	get_input()
	if wind:
		ext_vel = Vector2(0, 1) * windspeed
	else:
		ext_vel = Vector2.ZERO
	velocity = inp_vel + ext_vel
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

func boost():
	booster = true
	print("boost time")

func _on_bigshottimer_timeout() -> void:
	bigTrigger = false
	trigger = false
	if bulcount == 0:
		bulcount = 6

func _on_canvas_layer_startgame() -> void:
	dialEND = true

func _on_area_2d_windy() -> void:
	if wind:
		wind=false
	elif not wind:
		wind = true
	print("Windddyyyyyy")
