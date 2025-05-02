extends Area2D

@export var damage: int = 1
const speed: int = 1000

func _ready() -> void:
	connect("body_entered", Callable(self, "_on_body_entered"))

func _process(delta: float) -> void:
	position += transform.x * speed * delta

func _on_body_entered(body):
	if body.is_in_group("enemy"):
		if body.has_method("take_damage"):
			body.take_damage(damage)
		queue_free()
