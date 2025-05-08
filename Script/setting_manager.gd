extends Node

# Default settings file path
const SETTINGS_FILE := "user://ui_settings.cfg"

var settings := {
	"audio": {
		"music": 1.0,
		"sfx": 1.0,
		"voice": 1.0
	},
	"graphics": {
		"fullscreen": false,
		"resolution": "1920x1080"
	},
	"language": {  
		"selected": "en"
	},
	"controls": {
		"move_up": "w",
		"move_down": "s",
		"move_left": "a",
		"move_right": "d"
	},
	"gameplay": {
		"difficulty": 1,
		"show_tutorial": true
	}
}

enum DIFFICULTY {
	EASY,
	NORMAL,
	HARD
}
var current_game_difficulty: DIFFICULTY
var difficulty_label = ["EASY", "NORMAL", "HARD"]

var config = ConfigFile.new()

# Called when the autoload initializes
func _ready():
	load_settings()

# ========== SETTINGS MANAGEMENT ==========

# Get a setting value
func get_setting(category: String, key: String):
	return settings.get(category, {}).get(key, null)

# Set a setting value and save it
func set_setting(category: String, key: String, value):
	if settings.has(category):
		settings[category][key] = value
		save_settings()

# Save settings to a file
func save_settings():
	# Update audio settings to match the values from AudioManager
	settings["audio"]["music"] = AudioManager.volumes["music"]
	settings["audio"]["sfx"] = AudioManager.volumes["sfx"]
	settings["audio"]["voice"] = AudioManager.volumes.get("voice", 1.0) # if you have voice audio
	settings["language"]["selected"] = TranslationServer.get_locale() # Store the current language

	# Save all settings to file
	for category in settings.keys():
		for key in settings[category].keys():
			config.set_value(category, key, settings[category][key])
	config.save(SETTINGS_FILE)
	print("Settings saved")

# Load settings from file
func load_settings():
	if config.load(SETTINGS_FILE) == OK:
		for category in settings.keys():
			for key in settings[category].keys():
				settings[category][key] = config.get_value(category, key, settings[category][key])
		print("Loaded settings:", settings)
		# Apply loaded settings (audio, language, etc.)
		AudioManager.volumes["music"] = settings["audio"]["music"]
		AudioManager.volumes["sfx"] = settings["audio"]["sfx"]
		AudioManager.volumes["voice"] = settings["audio"].get("voice", 1.0)
		AudioManager.apply_volumes()

		TranslationServer.set_locale(settings["language"]["selected"])
	else:  
		print("No settings file found. Using default settings.")
