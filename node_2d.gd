extends Node2D


func _on_win_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		win_game()
		
func win_game() -> void:
	print("You Win!")
	get_tree().paused = true
	$WinScreen.show()
