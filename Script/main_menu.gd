extends Control


func _on_play_pressed() -> void:
	#changes to game
	SceneManager.change_scene("res://MainScenes/MainGame.tscn")
	


func _on_exit_pressed() -> void:
	#closes
	get_tree().quit()
	pass # Replace with function body.


func _on_settings_pressed() -> void:
	#change to settings menu
	
	pass # Replace with function body.
