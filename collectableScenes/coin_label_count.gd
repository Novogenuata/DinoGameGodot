extends Control

func _ready():
	var label = $CanvasLayer/Coins  
	CoinManager.label_node = label
	CoinManager.update_label()
