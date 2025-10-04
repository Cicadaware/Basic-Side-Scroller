extends StaticBody2D

@onready var collision = $CollisionShape2D

func toggle_state():
	visible = !visible
	collision.disabled = !visible
