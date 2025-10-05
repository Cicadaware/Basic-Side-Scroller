extends Node2D

@onready var timer = $Timer

func _on_win_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		win_game()
		
func win_game() -> void:
	print("You Win!")
	get_tree().paused = true
	
	var window_size = get_viewport().get_visible_rect().size
	
	var particleOffset = Vector2(200, 0)
	$WinScreen/Confetti.position = window_size / 2 - particleOffset
	$WinScreen/Confetti2.position = window_size / 2 + particleOffset
	
	$WinScreen/Sparkles.position = window_size / 2
	
	$WinScreen/Confetti.emitting = true
	$WinScreen/Confetti2.emitting = true
	$WinScreen.show()

func _on_restart_button_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()

func _ready():
	timer.start()
	timer.timeout.connect(_on_timer_timeout)
	get_tree().call_group("disappearingPlatform2", "toggle_state")

func _on_timer_timeout():
	get_tree().call_group("disappearingPlatform", "toggle_state")
	get_tree().call_group("disappearingPlatform2", "toggle_state")

func _on_death_area_body_entered(body):
	if body.is_in_group("Player"):
		respawn_player(body)

func respawn_player(player : RigidBody2D):
	
	player.linear_velocity = Vector2.ZERO
	player.angular_velocity = 0
	
	await get_tree().physics_frame
	
	player.global_position = $SpawnPoint.global_position
	player.rotation = 0

	player.set_sleeping(true)
	player.set_sleeping(false)
