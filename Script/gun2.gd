extends gun
class_name Gun2

@export var spread_angle = 15.0  
@export var cooldown_time = 1.0  
var can_shoot = true


func _process(delta: float) -> void:

	look_at(get_global_mouse_position())
	rotation_degrees = wrap(rotation_degrees, 0, 360)
	if rotation_degrees > 90 and rotation_degrees < 270:
		scale.y = -1
	else:
		scale.y = 1

	if not Input.is_action_pressed("shoot") and is_shooting:
		gun_animation.play("gun")
		is_shooting = false


	if Input.is_action_just_pressed("shoot") and not is_shooting and can_shoot:
		apply_recoil()
		spawn_bullet()
		spawn_muzzle_flash()
		gun_animation.play("openmouth")
		is_shooting = true


	if Input.is_action_pressed("left") or Input.is_action_pressed("right"):
		time_passed += delta * bob_speed
		gun_sprite.position.y = original_position.y + sin(time_passed) * bob_amount
	else:
		time_passed += delta * bob_speed_idle
		gun_sprite.position.y = original_position.y + sin(time_passed) * bob_amount_idle


func spawn_bullet():
	if not can_shoot:
		return
	can_shoot = false
	for i in [-1, 0, 1]:
		var b = bullet.instantiate()
		get_tree().root.add_child(b)
		b.global_position = muzzle.global_position
		b.rotation = rotation + deg_to_rad(spread_angle * i)
	await get_tree().create_timer(cooldown_time).timeout
	can_shoot = true
