extends PathFollow2D

var speed = 300

func _process(delta):
	progress += speed * delta 
