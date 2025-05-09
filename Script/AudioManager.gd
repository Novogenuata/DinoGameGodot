extends Node

enum AUDIO_BUSES {
	Master,
	Voice,
	SFX,
	Music
}

var volumes := {
	'master': 1.0,
	'voice': 1.0,
	'sfx': 1.0,
	'music': 1.0
}

func change_volume(audio_bus: int, value: float):
	value = clamp(value, 0.0, 1.0)
	match audio_bus:
		AUDIO_BUSES.Master:
			volumes["master"] = value
		AUDIO_BUSES.Voice:
			volumes["voice"] = value
		AUDIO_BUSES.SFX:
			volumes["sfx"] = value
		AUDIO_BUSES.Music:
			volumes["music"] = value
	apply_volumes()

func apply_volumes():
	var master = volumes["master"]

	# Master controls total volume scaling
	var final_music = master * volumes["music"]
	var final_sfx = master * volumes["sfx"]
	var final_voice = master * volumes.get("voice", 1.0)

	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear_to_db(master))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), linear_to_db(final_music))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), linear_to_db(final_sfx))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Voice"), linear_to_db(final_voice))
