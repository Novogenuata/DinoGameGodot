extends CharacterBody2D

@export var speed = 300
@onready var sprite = %PlayerSprite
@onready var finder = $Direction  # Marker2D
@onready var Actfinder = %ActionableFinder  # Area2D
@onready var Actfinder_collision = %ActionableFinder/CollisionShape2D  # CollisionShape2D inside Actfinder
@export var invincibility_time: float = 1.0


@export var max_health: int = 5 
var invincible: bool = false

var current_health: int
var spawn_position: Vector2



# Store original positions
var finder_original_x
var actfinder_original_x

func _ready():
	finder_original_x = finder.position.x
	actfinder_original_x = Actfinder.position.x
	current_health = max_health

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
	current_health -= amount
	print("Hit! health=", current_health)
	if current_health <= 0:
		_respawn()
		return
	# start invincibility countdown (no extra node needed)
	await get_tree().create_timer(invincibility_time).timeout 
	invincible = false
	print("Vulnerable again")
		
		
func heal(amount: int) -> void:
	current_health = min(current_health + amount, max_health)
	print("Healed! health =", current_health)
		

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
