# gate.gd
extends AnimatedSprite2D

func _ready():
	# Connect to the global CoinManager singleton
	print("Connecting to CoinManager.coin_count_changed…")
	var res = CoinManager.connect("coin_count_changed", Callable(self, "_on_coin_count_changed"))
	print("Signal connect result:", res)  # 0 = OK
	
	# Ensure we start in the "closed" animation
	play("closed")

func _on_coin_count_changed(new_count: int):
	print("Gate received coin count:", new_count)
	if new_count >= 20:
		open_gate()

func open_gate():
	# Force-play the "open" animation every time this is called
	print("Force-playing open animation")
	play("open")
