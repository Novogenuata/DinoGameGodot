extends CharacterBody2D

@export var speed = 300
@onready var sprite = %PlayerSprite
@onready var finder = $Direction  # Marker2D
@onready var Actfinder = %ActionableFinder  # Area2D
@onready var Actfinder_collision = %ActionableFinder/CollisionShape2D  # CollisionShape2D inside Actfinder

# Store original positions
var finder_original_x
var actfinder_original_x

func _ready():
	finder_original_x = finder.position.x
	actfinder_original_x = Actfinder.position.x

func get_input():
	var input_dir = Input.get_vector("left", "right", "up", "down")
	velocity = input_dir * speed

	if input_dir.length() > 0:
		sprite.play("Walk")

		if input_dir.x > 0:
			sprite.flip_h = true 
			finder.position.x = -finder_original_x  # Flip Marker2D
			Actfinder.position.x = -actfinder_original_x  # Flip Area2D
		elif input_dir.x < 0:
			sprite.flip_h = false 
			finder.position.x = finder_original_x  # Reset Marker2D
			Actfinder.position.x = actfinder_original_x  # Reset Area2D
	else:
		sprite.play("Idle")

	if Input.is_action_just_pressed("interact"):
		var actionables = Actfinder.get_overlapping_areas()
		if actionables.size() > 0:
			actionables[0].action()
			return

func _physics_process(delta):
	get_input()
	move_and_collide(velocity * delta)
