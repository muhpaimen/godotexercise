extends Area2D

signal wallhit(bshotpos: Vector2, expforce: float)

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("bigshot") or area.is_in_group("player"):
		var bs_pos = area.global_position
		var force = 800
		wallhit.emit(bs_pos, force)
		print("BIG SHOT BIG SHOT BIG SHOT")
