extends Node2D

@export var health: int
@export var movement_speed: int

@onready var player = $MainCharacter

func _ready() -> void:
	pass
	
func _physics_process(delta):
	if player:
		rotation = (player.global_position - global_position).normalized()
		position += transform.x * movement_speed * delta
