extends RigidBody2D

const SPEED      = 400.0
const JUMP_FORCE = 500.0
const MAX_JUMPS  = 2

var jumps_left: int = MAX_JUMPS
var on_floor: bool = false
var was_on_floor: bool = false

func _ready():
	contact_monitor = true
	max_contacts_reported = 10

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	# --- Ground check ---
	on_floor = false
	for i in range(state.get_contact_count()):
		var collider = state.get_contact_collider_object(i)
		var normal   = state.get_contact_local_normal(i)
		if collider and collider.is_in_group("Ground"):
			if normal.y < -0.7:  # mostly upwards, i.e. floor
				on_floor = true
				break

	# Reset jumps when landing
	if on_floor and not was_on_floor:
		jumps_left = MAX_JUMPS
	was_on_floor = on_floor

	# --- Horizontal movement ---
	var input_dir = Input.get_axis("ui_left", "ui_right")
	apply_central_impulse(Vector2(input_dir * SPEED * state.step, 0))

	# --- Jump ---
	if Input.is_action_just_pressed("ui_accept") and jumps_left > 0:
		apply_central_impulse(Vector2(0, -JUMP_FORCE))
		jumps_left -= 1

	# --- Rotate sprite for rolling effect ---
	if input_dir != 0:
		$RollingPart.rotation += linear_velocity.x * state.step / 50

	$shine.rotation = -rotation
