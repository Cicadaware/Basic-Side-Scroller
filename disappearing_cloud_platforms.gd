extends StaticBody2D

@onready var collision = $CollisionShape2D
@onready var collision2 = $Area2D/CollisionShape2D
@onready var sprites = [$Sprite2D]

var active_alpha := 1.0
var inactive_alpha := 0.25
func toggle_state():
	collision.disabled = !collision.disabled
	collision2.disabled = !collision2.disabled
	
	var target_alpha = inactive_alpha if collision.disabled else active_alpha
	for sprite in sprites:
		sprite.modulate = Color(1, 1, 1, target_alpha)
