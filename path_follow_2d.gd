extends PathFollow2D

var speed = 200

func _process(delta):
	progress += speed * delta 

func _ready():
	loop = true
	rotates = true
