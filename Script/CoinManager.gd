extends Node

signal coin_count_changed(new_count: int)

var coin_count: int = 0
var label_node: Label = null

func add_coin():

	coin_count += 1
	update_label()
	emit_signal("coin_count_changed", coin_count)


func update_label():
	if label_node:
		label_node.text = str("Coins: ", coin_count)
		
	if coin_count >= 300:
	
		SceneManager.change_scene("res://MainScenes/win_scene.tscn")


	
	
