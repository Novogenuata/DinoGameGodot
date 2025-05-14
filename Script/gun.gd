extends Node2D
class_name gun

@export var bob_speed = 20.0
@export var bob_amount = 3.0
@export var bob_speed_idle = 10.0
@export var bob_amount_idle = 2.0
@export var cooldown = 0.3
@export var use_animations: bool = true  

const bullet = preload("res://CharacterScenes/bullet.tscn")

@onready var muzzle = $Muzzle
@onready var gun_sprite = $GunSprite  
@onready var muzzle_flash = $CPUParticles2D  
@onready var gun_animation = $GunSprite  # Can be AnimatedSprite2D or Sprite2D

var time_passed = 0.0
var original_position  
var original_rotation  
var is_shooting = false 
var cooldown_timer = 0.0

func _ready():
	original_position = gun_sprite.position  
	original_rotation = gun_sprite.rotation_degrees  
	muzzle_flash.emitting = false  

func _process(delta: float) -> void:
	look_at(get_global_mouse_position())
	rotation_degrees = wrap(rotation_degrees, 0, 360)

	if rotation_degrees > 90 and rotation_degrees < 270:
		scale.y = -1
	else:
		scale.y = 1
		
	if cooldown_timer > 0.0:
		cooldown_timer -= delta

	# Stop shooting and return to idle animation if needed
	if !Input.is_action_pressed("shoot") and is_shooting:
		if use_animations and gun_animation.has_method("play"):
			gun_animation.play("gun")
		is_shooting = false
	
	# Handle shooting
	if Input.is_action_pressed("shoot") and cooldown_timer <= 0.0:
		apply_recoil()
		spawn_bullet()
		spawn_muzzle_flash()
		if use_animations and gun_animation.has_method("play"):
			gun_animation.play("openmouth")
		is_shooting = true
		cooldown_timer = cooldown

	# Bobbing effect
	if Input.is_action_pressed("left") or Input.is_action_pressed("right"):
		time_passed += delta * bob_speed
		gun_sprite.position.y = original_position.y + sin(time_passed) * bob_amount
	else:
		time_passed += delta * bob_speed_idle
		gun_sprite.position.y = original_position.y + sin(time_passed) * bob_amount_idle

func apply_recoil():
	gun_sprite.position = original_position + Vector2(-5, 0)
	gun_sprite.rotation_degrees = original_rotation - 5

	var tween = get_tree().create_tween()
	tween.tween_property(gun_sprite, "position", original_position, 0.1)
	tween.tween_property(gun_sprite, "rotation_degrees", original_rotation, 0.1)

func spawn_bullet():
	var bullet_instance = bullet.instantiate()
	get_tree().root.add_child(bullet_instance)
	bullet_instance.global_position = muzzle.global_position
	bullet_instance.rotation = rotation
	
func spawn_muzzle_flash():
	muzzle_flash.global_position = muzzle.global_position
	muzzle_flash.emitting = true
	muzzle_flash.emitting = false  
