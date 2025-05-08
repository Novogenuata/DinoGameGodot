extends Control

func _ready():
	# Load settings (language and volume) when the main menu is ready
	AudioManager.load_settings()

func _on_play_pressed() -> void:
	# Change to game scene
	SceneManager.change_scene("res://MainScenes/MainGame.tscn")

func _on_exit_pressed() -> void:
	# Close the game
	get_tree().quit()

func _on_settings_pressed() -> void:
	# Change to settings menu
	SceneManager.change_scene("res://MainScenes/settings_menu.tscn")
