extends RigidBody2D

const SPEED = 400.0
const JUMP_FORCE = 500.0
const MAX_JUMPS = 2

var jumps_left = MAX_JUMPS
var was_on_floor = false

func _physics_process(delta):
	var input_dir = Input.get_axis("ui_left", "ui_right")
	apply_central_impulse(Vector2(input_dir * SPEED * delta, 0))
	
	# Check floor
	var on_floor = $FloorRay.is_colliding()
	
	# Reset jumps only when landing
	if on_floor and not was_on_floor:
		jumps_left = MAX_JUMPS
	
	was_on_floor = on_floor
	
	# Jump
	if Input.is_action_just_pressed("ui_accept") and jumps_left > 0:
		apply_central_impulse(Vector2(0, -JUMP_FORCE))
		jumps_left -= 1

	# Rotate sprite based on horizontal speed
	if $Sprite2D:
		$Sprite2D.rotation += linear_velocity.x * delta / 50
