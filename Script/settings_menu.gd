extends Control

@onready var english_button = %English
@onready var french_button = %French

@onready var music_slider = %musicslider
@onready var master_slider = %masterslider
@onready var sfx_slider = %sfxslider

var selected_language := "en"  # Default language

func _ready():
	# Initialize sliders with current volume settings from AudioManager
	music_slider.value = AudioManager.volumes["music"]
	master_slider.value = AudioManager.volumes["master"]
	sfx_slider.value = AudioManager.volumes["sfx"]
	
	# Load current language from saved settings
	var config = ConfigFile.new()
	if config.load("user://settings.cfg") == OK:
		selected_language = config.get_value("general", "language", "en")
		TranslationServer.set_locale(selected_language)

	# Optional: visually indicate current language (if necessary)

# Volume sliders
func _on_musicslider_value_changed(value: float) -> void:
	AudioManager.change_volume(AudioManager.AUDIO_BUSES.Music, value)

func _on_masterslider_value_changed(value: float) -> void:
	AudioManager.change_volume(AudioManager.AUDIO_BUSES.Master, value)

func _on_sfxslider_value_changed(value: float) -> void:
	AudioManager.change_volume(AudioManager.AUDIO_BUSES.SFX, value)

# Save settings when pressing the save button
func _on_savebutton_pressed() -> void:
	# Save the current language setting in SettingsManager
	SettingManager.set_setting("language", "selected", selected_language)
	
	# Save all settings (audio, language) using SettingsManager
	SettingManager.save_settings()

	# Switch to the main menu
	SceneManager.change_scene("res://MainScenes/main_menu.tscn")

# Language selection buttons
func _on_english_pressed() -> void:
	# Set language to English and update in SettingsManager
	selected_language = "en"
	TranslationServer.set_locale("en")
	SettingManager.set_setting("language", "selected", selected_language)

func _on_french_pressed() -> void:
	# Set language to French and update in SettingsManager
	selected_language = "fr"
	TranslationServer.set_locale("fr")
	SettingManager.set_setting("language", "selected", selected_language)
