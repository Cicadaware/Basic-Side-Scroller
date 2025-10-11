extends CPUParticles2D

@export var target : Node2D
@export var offset : Vector2 = Vector2.ZERO

func _process(_delta):
	if target:
		global_position = target.global_position + offset
