extends CharacterBody2D

@export var health: int
@export var movement_speed: int

@onready var player = get_tree().get_nodes_in_group("player")[0]
var anim_sprite: AnimatedSprite2D = null
var can_damage: bool = true
var attack_timer: Timer  # Timer to handle attack cooldown

@export var Coin = preload("res://collectableScenes/coin.tscn")

func _ready():
	anim_sprite = _find_first_animated_sprite(self)

	# create and configure attack cooldown timer
	attack_timer = Timer.new()
	attack_timer.one_shot = true
	attack_timer.wait_time = 0.5  # duration of attack animation / invincibility
	add_child(attack_timer)
	attack_timer.connect("timeout", Callable(self, "_on_attack_timeout"))

func _find_first_animated_sprite(node: Node) -> AnimatedSprite2D:
	for child in node.get_children():
		if child is AnimatedSprite2D:
			return child
		var found = _find_first_animated_sprite(child)
		if found:
			return found
	return null

func _process(delta):
	if not player:
		return

	var direction = (player.global_position - global_position).normalized()
	velocity = direction * movement_speed

	if anim_sprite:
		anim_sprite.flip_h = direction.x < 0

func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)

	if collision:
		var body = collision.get_collider()

		if body is CharacterBody2D and body.is_in_group("player") and can_damage:
			body.take_damage(1)
			print("damage taken")
			can_damage = false
			anim_sprite.play("attack")
			attack_timer.start()
	else:
		# only return to default if not in attack
		if anim_sprite.animation != "attack":
			anim_sprite.play("default")

# called when attack_timer times out (1.5s later)
func _on_attack_timeout():
	can_damage = true
	anim_sprite.play("default")

func take_damage(amount: int):
	health -= amount
	if health <= 0:
		call_deferred("_die")

func _die():
	# Instantiate the coin and add it to the parent
	var coin_instance = Coin.instantiate()
	get_parent().add_child(coin_instance)
	coin_instance.global_position = global_position

	# Remove this enemy from the scene
	queue_free()
