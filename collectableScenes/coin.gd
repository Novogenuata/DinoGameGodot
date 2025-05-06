extends Node2D

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		CoinManager.add_coin()

		# Hide the coin visually and disable collision
		visible = false
		$Area2D.monitoring = false
		$Area2D.set_deferred("monitorable", false)
		
		# Play pickup sound
		var audio = $Area2D/AudioStreamPlayer2D
		audio.play()

		# Connect to sound's finished signal
		if not audio.is_connected("finished", Callable(self, "_on_sound_finished")):
			audio.connect("finished", Callable(self, "_on_sound_finished"))

func _on_sound_finished():
	queue_free()
