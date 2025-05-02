extends Node

enum AUDIO_BUSES{
	Master,
	#Voice,
	SFX,
	Music
}
var volumes :={
	'master':1.0,
	'sfx':1.0,
	#'voice':1.0,
	'music':1.0
}
func change_volume(audio_bus: int, value: float):
	value = clamp(value, 0, 1)
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
