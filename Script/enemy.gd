extends CharacterBody2D

@export var health: int
@export var movement_speed: int

@onready var player = get_tree().get_nodes_in_group("player")[0]
var anim_sprite: AnimatedSprite2D = null

@export var Coin = preload("res://collectableScenes/coin.tscn")

func _ready():
	anim_sprite = _find_first_animated_sprite(self)

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
		
		if body is CharacterBody2D and body.is_in_group("player"):
			anim_sprite.play("attack")
		else:
			anim_sprite.play("default")
	else:
		
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
