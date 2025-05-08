extends Node

enum AUDIO_BUSES {
	Master,
	SFX,
	Music
}

var volumes := {
	'master': 1.0,
	'sfx': 1.0,
	'music': 1.0
}

var settings_path := "user://settings.cfg"

func _ready():
	load_settings()
	apply_volumes()

func change_volume(audio_bus: int, value: float):
	value = clamp(value, 0.0, 1.0)
	match audio_bus:
		AUDIO_BUSES.Master:
			volumes["master"] = value
		AUDIO_BUSES.SFX:
			volumes["sfx"] = value
		AUDIO_BUSES.Music:
			volumes["music"] = value
	apply_volumes()

func apply_volumes():
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear_to_db(volumes["master"]))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), linear_to_db(volumes["sfx"]))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), linear_to_db(volumes["music"]))

func save_settings(language_code: String = "en"):
	var config = ConfigFile.new()
	config.set_value("audio", "master", volumes["master"])
	config.set_value("audio", "sfx", volumes["sfx"])
	config.set_value("audio", "music", volumes["music"])
	config.set_value("general", "language", language_code)
	config.save(settings_path)

func load_settings():
	var config = ConfigFile.new()
	var err = config.load(settings_path)
	if err == OK:
		volumes["master"] = config.get_value("audio", "master", 1.0)
		volumes["sfx"] = config.get_value("audio", "sfx", 1.0)
		volumes["music"] = config.get_value("audio", "music", 1.0)
		apply_volumes()
		var language_code = config.get_value("general", "language", "en")
		TranslationServer.set_locale(language_code)
