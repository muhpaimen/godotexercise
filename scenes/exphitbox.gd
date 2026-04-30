extends Area2D

signal kaboom

func _ready() -> void:
	var tween = create_tween()
	tween.set_loops(15)
	tween.tween_property($Sprite2D,"modulate:a", 0.1, 0.1)
	tween.tween_property($Sprite2D,"modulate:a", 1.0, 0.1)

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D and body.is_in_group("player"):
		kaboom.emit()


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		kaboom.emit()
