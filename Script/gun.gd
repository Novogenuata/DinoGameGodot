extends Node2D

@export var bob_speed = 20.0
@export var bob_amount = 3.0

@export var bob_speed_idle = 10.0
@export var bob_amount_idle = 2.0

const bullet = preload("res://CharacterScenes/bullet.tscn")

@onready var muzzle = $Muzzle
@onready var gun_sprite = $GunSprite  
@onready var muzzle_flash = $CPUParticles2D  
@onready var gun_animation = $GunSprite  # Assuming GunSprite is an AnimatedSprite2D

var time_passed = 0.0
var original_position  
var original_rotation  
var is_shooting = false  # Flag to track if shooting is happening

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

	# Check if shooting stopped and return to idle animation
	if !Input.is_action_pressed("shoot") and is_shooting:
		gun_animation.play("gun")  # Play the idle animation when not shooting
		is_shooting = false
	
	# Handle shooting
	if Input.is_action_just_pressed("shoot") and !is_shooting:
		apply_recoil()
		spawn_bullet()
		spawn_muzzle_flash()
		gun_animation.play("openmouth")  # Play the openmouth animation when shooting
		is_shooting = true

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
