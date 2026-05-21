extends Area2D

signal gothit()
signal windy()

func _on_hit_body_entered(body):
	print("aiyayayay")
	if body.is_in_group("enemies"):
		gothit.emit()
		get_parent().iframe()


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemies"):
		get_parent().iframe()
	
	if area.is_in_group("windarea"):
		windy.emit()


func _on_area_exited(area: Area2D) -> void:
	if area.is_in_group("windarea"):
		windy.emit()
