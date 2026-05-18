extends CanvasLayer

@onready var dialText = $NinePatchRect/RichTextLabel
@onready var dialFace = $NinePatchRect/Sprite2D

#sprites:
@onready var face_insane = preload("res://assets/madface.png")
@onready var face_sad = preload("res://assets/sadface.png")
@onready var face_smug = preload("res://assets/smugfach.png")

var dialData = {}
var current_node = "Intro"
signal startgame

func load_dialogue(path: String):
	if FileAccess.file_exists(path):
		var dialFile = FileAccess.open(path, FileAccess.READ)
		var content = dialFile.get_as_text()
		dialData = JSON.parse_string(content)
	else :
		print("NOOOOOOO I FUCKING FAILED HER")

func display_node():
	if dialData.has(current_node):
		var node = dialData[current_node]
		dialText.text = node["text"]
		
		if node["face"] == "smug":
			dialFace.texture = face_smug
		elif node["face"] == "sad":
			dialFace.texture = face_sad
		else:
			dialFace.texture = face_insane
	else:
		dialText.text = "im old"
		hide()

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("shoot"):
		next_text()

func next_text():
	var node = dialData[current_node]
	var next_node = node["next"]
	
	if next_node != "NULL":
		current_node = next_node
		display_node()
	else:
		print("aiaiaiai")
		queue_free()
		startgame.emit()

func _ready() -> void:
	load_dialogue("res://assets/dialog.json")
	display_node()
