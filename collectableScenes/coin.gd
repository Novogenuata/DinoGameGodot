extends Node2D


func _on_area_2d_body_entered(body: Node2D) -> void:
	print("body entered:", body.name)
	if body.is_in_group("player"):
		CoinManager.add_coin()
		queue_free()
	pass # Replace with function body.
