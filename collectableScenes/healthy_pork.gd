extends Node2D


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and body.current_health < body.max_health:
		body.heal(1)
		queue_free()  # Remove the pickup from the game
		
