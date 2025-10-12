extends StaticBody2D

@export var left_limit: float = 0
@export var right_limit: float = 2700.0
@export var speed: float = 400.0

var direction: int = 1
var start_x: float
var timespan: float = 3.0

func _ready():
	start_x = position.x

func _process(delta):
	position.x += direction * speed * delta

	# Reverse direction when reaching limits
	if position.x > start_x + right_limit:
		position.x = start_x + right_limit
		await get_tree().create_timer(timespan).timeout
		direction = -1
	elif position.x < start_x + left_limit:
		position.x = start_x + left_limit
		await get_tree().create_timer(timespan).timeout
		direction = 1
