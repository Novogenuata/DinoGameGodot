extends Node2D

@export var health: int
@export var movement_speed: int

@onready var player = get_tree().get_nodes_in_group("player")[0]

func _ready() -> void:
	pass
	
func _process(delta):
	if player:
		# Direction to player
		var direction = (player.global_position - global_position).normalized()
		
		# Move directly toward player
		position += direction * movement_speed * delta
		
		# Rotate to face the movement direction
		rotation = direction.angle()
