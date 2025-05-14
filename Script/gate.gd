extends AnimatedSprite2D

func _ready():
	update_gate()
	CoinManager.coin_count_changed.connect(_on_coin_count_changed)

func _on_coin_count_changed(new_count: int) -> void:
	update_gate()

func update_gate() -> void:
	if CoinManager.coin_count >= 20:
		print("Opening gate")  # debug
		play("open")
	else:
		print("Closing gate")  # debug
		play("closed")
