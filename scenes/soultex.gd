extends Sprite2D

@onready var chgtex = preload("res://assets/soulcc.png")
@onready var uctex = preload("res://assets/soul.png")

func uncharge():
	texture = uctex

func charge():
	texture = chgtex
