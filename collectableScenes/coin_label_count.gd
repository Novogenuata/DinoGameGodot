extends Control

func _ready():
	var label = $Coins  # or get_node("Coins")
	CoinManager.label_node = label
	CoinManager.update_label()
