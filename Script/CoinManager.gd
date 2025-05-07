extends Node

var coin_count: int = 0
var label_node: Label = null

func add_coin():
	coin_count += 1
	update_label()

func update_label():
	if label_node:
		label_node.text = str("Coins: ", coin_count)
