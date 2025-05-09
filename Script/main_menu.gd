extends Control

"""func _ready():
	SettingsManager.load_settings()

	# Apply saved audio settings
	for bus in AudioManager.AUDIO_BUSES.values():
		var key := ""
		match bus:
			AudioManager.AUDIO_BUSES.Master:
				key = "master"
			AudioManager.AUDIO_BUSES.Voice:
				key = "voice"
			AudioManager.AUDIO_BUSES.SFX:
				key = "sfx"
			AudioManager.AUDIO_BUSES.Music:
				key = "music"
		var raw_value = SettingsManager.get_setting("audio", key)
		var volume: float = (raw_value != null and typeof(raw_value) in [TYPE_FLOAT, TYPE_INT]) ? float(raw_value) : 1.0
		AudioManager.change_volume(bus, volume)

	# Apply saved language
	var lang = SettingsManager.get_setting("language", "selected")
	TranslationServer.set_locale(lang if lang != null else "en")"""


func _on_play_pressed() -> void:
	# Change to game scene
	SceneManager.change_scene("res://MainScenes/MainGame.tscn")

func _on_exit_pressed() -> void:
	# Close the game
	get_tree().quit()

func _on_settings_pressed() -> void:
	# Change to settings menu
	SceneManager.change_scene("res://MainScenes/settings_menu.tscn")
