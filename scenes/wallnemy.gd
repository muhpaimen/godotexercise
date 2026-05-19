extends Node2D

signal movenow(vel: Vector2, speed)
signal falldown(bspos: Vector2, exp_force: float)

func _ready() -> void:
	movenow.emit(Vector2(-1, 0), 200)

func _physics_process(delta: float) -> void:
	pass

func _on_area_2d_wallhit(bshotpos: Vector2, expforce: float) -> void:
	falldown.emit(bshotpos, expforce)
