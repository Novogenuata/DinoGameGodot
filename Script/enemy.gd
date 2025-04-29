extends CharacterBody2D

@export var health: int
@export var movement_speed: int

@onready var player = get_tree().get_nodes_in_group("player")[0]

func _ready() -> void:
	pass
	
func _process(delta):
	if player:
		var direction = (player.global_position - global_position).normalized()
		rotation = direction.angle()
		velocity = direction * movement_speed

func _physics_process(delta: float):
	move_and_collide(velocity * delta)
