extends Control


func _on_play_pressed() -> void:
	SceneManager.change_scene("res://MainScenes/MainGame.tscn")
	


func _on_exit_pressed() -> void:
	get_tree().quit()
	pass # Replace with function body.
