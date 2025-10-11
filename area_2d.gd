extends Area2D

@onready var particles = get_node("/root/Node2D/Cloud_flight_particle")

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))
	connect("body_exited", Callable(self, "_on_body_exited"))

func _on_body_entered(body):
	if body.is_in_group("Player"):  # optional safety check
		particles.emitting = true

func _on_body_exited(body):
	if body.is_in_group("Player"):
		particles.emitting = false
