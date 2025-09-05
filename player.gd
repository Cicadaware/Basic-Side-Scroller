extends RigidBody2D

# === Constants ===
const SPEED      = 400.0
const JUMP_FORCE = 500.0
const MAX_JUMPS  = 2

# === Variables ===
var jumps_left: int = MAX_JUMPS
var on_floor: bool = false
var was_on_floor: bool = false

func _physics_process(delta: float) -> void:
	# --- Horizontal movement ---
	var input_dir = Input.get_axis("ui_left", "ui_right")
	apply_central_impulse(Vector2(input_dir * SPEED * delta, 0))

	# --- Check floor using overlaps ---
	on_floor = false
	for body in $FloorArea.get_overlapping_bodies():
		if body.is_in_group("Ground"):
			on_floor = true
			break

	# Reset jumps when landing (transition air → floor)
	if on_floor and not was_on_floor:
		jumps_left = MAX_JUMPS

	was_on_floor = on_floor

	# --- Jump ---
	if Input.is_action_just_pressed("ui_accept") and jumps_left > 0:
		apply_central_impulse(Vector2(0, -JUMP_FORCE))
		jumps_left -= 1

	# --- Rotate sprite for rolling effect ---
	if $Sprite2D:
		$Sprite2D.rotation += linear_velocity.x * delta / 50
