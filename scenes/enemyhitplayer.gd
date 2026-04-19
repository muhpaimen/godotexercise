extends Area2D

func _on_hitbox_body_entered(body):
	if body is CharacterBody2D and body.is_in_group("player"):
		get_parent().hit()


func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D and body.is_in_group("player"):
		get_parent().hit()
