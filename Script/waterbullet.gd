extends Area2D


@export var damage: int = 1
@export var speed = 500
@export var lifetime = 0.2

func _ready():
	set_as_top_level(true)
	await get_tree().create_timer(lifetime).timeout
	queue_free()

func _process(delta):
	position += Vector2.RIGHT.rotated(rotation) * speed * delta


func _on_body_entered(body):
	if body.is_in_group("enemy"):
		if body.has_method("take_damage"):
			body.take_damage(damage)
		queue_free()
