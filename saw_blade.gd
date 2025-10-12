extends Sprite2D

var rotation_speed = 180

func _process(delta):
	rotation -= deg_to_rad(rotation_speed) * delta
