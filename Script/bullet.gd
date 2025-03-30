extends Node2D


const speed: int = 1000
func _ready() -> void:
	pass
func _process(delta: float) -> void:
	position += transform.x * speed * delta
