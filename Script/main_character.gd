extends CharacterBody2D

@export var speed = 300
@onready var sprite = %PlayerSprite
@onready var finder = $Direction  # Marker2D
@onready var Actfinder = %ActionableFinder  # Area2D
@onready var Actfinder_collision = %ActionableFinder/CollisionShape2D  # CollisionShape2D inside Actfinder
@export var invincibility_time: float = 1.0
@onready var heart_bar = %HeartBar
@export var heart_scene = preload("res://MainScenes/heart_container.tscn")

@onready var hit_sound = $HitSound


@export var max_health: int = 5 
var invincible: bool = false

var current_health: int
var spawn_position: Vector2



# Store original positions
var finder_original_x
var actfinder_original_x

var heart_nodes: Array = []

func _ready():
	finder_original_x = finder.position.x
	actfinder_original_x = Actfinder.position.x
	current_health = max_health
	spawn_hearts()

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


func _on_secret_gate_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		#change to the water scene with the water gun
		SceneManager.change_scene("res://MainScenes/water_scene.tscn")




func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		#change to the water scene with the water gun
		SceneManager.change_scene("res://infinite_marshlands.tscn")


func _on_return_gate_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		#change to the water scene with the water gun
		SceneManager.change_scene("res://MainScenes/MainGame.tscn")
		
		
func take_damage(amount: int) -> void:
	if invincible:
		return
	invincible = true
	
	# Play the hit sound
	hit_sound.play()
	
	current_health -= amount
	for i in range(amount):
		if heart_nodes.size() > 0:
			var heart = heart_nodes.pop_back()
			heart.queue_free()
	print("Hit! health=", current_health)
	if current_health <= 0:
		_respawn()
		return
	await get_tree().create_timer(invincibility_time).timeout 
	invincible = false
	print("Vulnerable again")
		
		
func heal(amount: int) -> void:
	var new_health = min(current_health + amount, max_health)
	var hearts_to_add = new_health - current_health
	current_health = new_health
	print("Healed! health =", current_health)

	for i in range(hearts_to_add):
		if current_health + i <= max_health:
			var heart = heart_scene.instantiate()
			heart_bar.add_child(heart)

			if heart.has_node("AnimatedSprite2D"):
				var anim = heart.get_node("AnimatedSprite2D")
				anim.play("default")
			
			heart_nodes.append(heart)
		

func _respawn() -> void:
	Globalmanager.emit_signal("player_died")
	SceneManager.change_scene("res://MainScenes/MainGame.tscn")
	sprite.play("sleep")
	current_health  = max_health


func _on_to_flower_lands_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and CoinManager.coin_count >= 20:
		CoinManager.coin_count -= 20
		SceneManager.change_scene("res://MainScenes/infini_flowerlands.tscn")
	else:
		print("Not enough coins. You need 20 to enter.")
		
func spawn_hearts():
	heart_nodes.clear()

	for child in heart_bar.get_children():
		child.queue_free()

	for i in range(max_health):
		var heart = heart_scene.instantiate()
		heart_bar.add_child(heart)
		heart_nodes.append(heart)
