extends Control


func _on_mm_pressed() -> void:
	SceneManager.change_scene("res://MainScenes/main_menu.tscn")




func _on_e_pressed() -> void:
	get_tree().quit()
