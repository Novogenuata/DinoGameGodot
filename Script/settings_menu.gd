extends Control


func _on_musicslider_value_changed(value: float) -> void:
	pass # Replace with function body.


func _on_masterslider_value_changed(value: float) -> void:
	pass # Replace with function body.


func _on_sfxslider_value_changed(value: float) -> void:
	pass # Replace with function body.


func _on_savebutton_pressed() -> void:
	#needs to save the sound settings
	#changes back to main menu
	SceneManager.change_scene("res://MainScenes/main_menu.tscn")
	
	pass # Replace with function body.
