extends gun

const water_bullet = preload("res://CharacterScenes/waterbullet.tscn")
const SPREAD_ANGLE = 5.0  
const POSITION_JITTER = 2.0  

func spawn_bullet():
	var bullet_instance = water_bullet.instantiate()
	get_tree().root.add_child(bullet_instance)

	
	var jitter = Vector2(
		randf_range(-POSITION_JITTER, POSITION_JITTER),
		randf_range(-POSITION_JITTER, POSITION_JITTER)
	)
	bullet_instance.global_position = muzzle.global_position + jitter


	var angle_offset = deg_to_rad(randf_range(-SPREAD_ANGLE, SPREAD_ANGLE))
	bullet_instance.rotation = rotation + angle_offset
