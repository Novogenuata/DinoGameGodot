extends Node2D


@onready var bullet_scene = preload("res://collectableScenes/flame.tscn")

var bullet_duration := 3.0 
var bullets := [] 


func _on_body_entered(body: Node2D):
	if body.is_in_group("player"):
		_on_skull_picked_up(body)
		queue_free() 

func _on_skull_picked_up(player: Node2D):
	spawn_bullets_around_player(player)
	await get_tree().create_timer(bullet_duration).timeout
	remove_bullets()

func spawn_bullets_around_player(player: Node2D):
	var num_bullets = 12  
	var radius = 100 
	for i in range(num_bullets):
		var angle = i * TAU / num_bullets  
		var bullet = bullet_scene.instantiate()

	
		bullet.player = player
		bullet.angle = angle
		bullet.radius = radius
		bullet.rotation_speed = 2 * PI / bullet_duration 

		if bullet.has_method("activate_area_damage"):
			bullet.activate_area_damage()

		get_tree().current_scene.add_child(bullet)
		bullets.append(bullet)



		if bullet.has_method("activate_area_damage"):
			bullet.activate_area_damage()

		get_tree().current_scene.add_child(bullet)
		bullets.append(bullet)

func remove_bullets():
	for bullet in bullets:
		if is_instance_valid(bullet):
			bullet.queue_free()
	bullets.clear()
