extends Control

@onready var english_button = %English
@onready var french_button = %French

@onready var music_slider = %musicslider
@onready var master_slider = %masterslider
@onready var sfx_slider = %sfxslider

var selected_language := "en"  # Default language

"""func _ready():
	var music = SettingsManager.get_setting("audio", "music")
	var master = SettingsManager.get_setting("audio", "master")
	var sfx = SettingsManager.get_setting("audio", "sfx")

	music_slider.value = music if music != null else 1.0
	master_slider.value = master if master != null else 1.0
	sfx_slider.value = sfx if sfx != null else 1.0

	# Language
	var config = ConfigFile.new()
	if config.load("user://settings.cfg") == OK:
		selected_language = config.get_value("general", "language", "en")
		TranslationServer.set_locale(selected_language)
"""

# Volume sliders
func _on_musicslider_value_changed(value: float) -> void:
	AudioManager.change_volume(AudioManager.AUDIO_BUSES.Music, value)

func _on_masterslider_value_changed(value: float) -> void:
	AudioManager.change_volume(AudioManager.AUDIO_BUSES.Master, value)

func _on_sfxslider_value_changed(value: float) -> void:
	AudioManager.change_volume(AudioManager.AUDIO_BUSES.SFX, value)

# Save settings when pressing the save button
func _on_savebutton_pressed() -> void:
	# Save volume settings
	"""SettingsManager.set_setting("audio", "music", music_slider.value)
	SettingsManager.set_setting("audio", "master", master_slider.value)
	SettingsManager.set_setting("audio", "sfx", sfx_slider.value)

	# Save language (already handled by language buttons)
	
	SettingsManager.save_settings()"""

	SceneManager.change_scene("res://MainScenes/main_menu.tscn")

# Language selection buttons
func _on_english_pressed() -> void:
	# Set language to English and update in SettingsManager
	selected_language = "en"
	TranslationServer.set_locale("en")
	#SettingManager.set_setting("language", "selected", selected_language)

func _on_french_pressed() -> void:
	# Set language to French and update in SettingsManager
	selected_language = "fr"
	TranslationServer.set_locale("fr")
	#SettingManager.set_setting("language", "selected", selected_language)
