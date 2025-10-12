extends Area2D

@onready var collision_l = get_node("../collisionwall_l")
@onready var collision_r = get_node("../collisionwall_r")
@onready var walls = get_node("../walls")

func _ready():
	collision_r.disabled = true
	collision_l.disabled = true
	walls.visible = false
	connect("body_entered", Callable(self, "_on_body_entered"))
	connect("body_exited", Callable(self, "_on_body_exited"))
	
func _on_body_entered(body):
	if body.is_in_group("Player"):  # optional safety check
		collision_r.set_deferred("disabled", false)
		collision_l.set_deferred("disabled", false)
		walls.visible = true

func _on_body_exited(body):
	if body.is_in_group("Player"):
		collision_r.set_deferred("disabled", true)
		collision_l.set_deferred("disabled", true)
		walls.visible = false
