extends Node2D

@export var pickup_sound: AudioStream  

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		print("body entered:", body.name)


		if pickup_sound:
			var sfx = AudioStreamPlayer2D.new()
			sfx.stream = pickup_sound
			add_child(sfx)
			sfx.play()


		Globalmanager.has_water_gun = true

		if body.has_method("add_water_gun"):
			body.add_water_gun()

		queue_free()
