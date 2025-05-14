extends Node2D

@export var damage = 1
var player: Node2D
var angle: float = 0.0
var radius: float = 100.0
var rotation_speed: float = 1.0

var fading := false
var fade_duration := 1.0  
var fade_timer := 0.0

func _ready():
	if $flame:
		$flame.connect("body_entered", Callable(self, "_on_body_entered"))
	
	$Timer.start()

func _process(delta):
	if player and is_instance_valid(player):
		angle += rotation_speed * delta
		global_position = player.global_position + Vector2(cos(angle), sin(angle)) * radius

	if fading:
		fade_timer += delta
		var t := fade_timer / fade_duration
		if t < 0.0:
			t = 0.0
		elif t > 1.0:
			t = 1.0
		modulate.a = 1.0 - t  
		if t >= 1.0:
			queue_free()

func _on_body_entered(body):
	if body.is_in_group("enemy") and body.has_method("take_damage"):
		body.take_damage(damage)

func _on_timer_timeout() -> void:
	fading = true
