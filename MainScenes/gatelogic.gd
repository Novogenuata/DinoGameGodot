extends Node2D
@onready var sprite = $AnimatedSprite2D
@onready var hb = $StaticBody2D

@onready var col = $StaticBody2D/CollisionShape2D

func _ready():
	update_gate()
	CoinManager.coin_count_changed.connect(_on_coin_count_changed)

func _on_coin_count_changed(new_count: int) -> void:
	update_gate()

func update_gate() -> void:
	if CoinManager.coin_count >= 20:
		print("Opening gate")  
		sprite.play("open")
		col.disabled = true
		
	
	else:
		print("Closing gate")  
		sprite.play("closed")
		col.disabled = false
	
