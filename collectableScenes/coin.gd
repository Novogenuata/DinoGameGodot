extends Node2D

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		CoinManager.add_coin()

	
		visible = false
		$Area2D.monitoring = false  
		
		# Play pickup sound
		var audio = $Area2D/AudioStreamPlayer2D
		audio.play()


		if not audio.is_connected("finished", Callable(self, "_on_sound_finished")):
			audio.connect("finished", Callable(self, "_on_sound_finished"))

func _on_sound_finished():
	queue_free()  
