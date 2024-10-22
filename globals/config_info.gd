extends Node

var DEFAULT_CONFIG = {
	"display": {
		"brightness": 1,
		"display_mode": 0
	},
	"general": {
		"vhs_effects": true,
		"vhs_effects_intensity": 1
	},
	"sound": {
		"ambiance_volume": 5,
		"mute_all_sounds": false,
		"overall_volume": 5,
		"sfx_volume": 5,
		"music_volume": 5,
	}
}
var min_shader_strength = {
	"shake": 0.0,
	"noiseQuality":  250,
	"noiseIntensity": 0.0,
	"offsetIntensity": 0.0,
	"colorOffsetIntensity": 0.0,
	"pixelSize": 1024,
	"grainIntensity": 0.0
}
var med_shader_strength = {
	"shake": 0.015,
	"noiseQuality":  250,
	"noiseIntensity": 0.001,
	"offsetIntensity": 0.0045,
	"colorOffsetIntensity": 0.2,
	"pixelSize": 605,
	"grainIntensity":0.08,

}
var max_shader_strength = {
	"shake": 0.015,
	"noiseQuality":  250.0,
	"noiseIntensity": 0.006,
	"offsetIntensity": 0.0045,
	"colorOffsetIntensity": 1.0,
	"pixelSize": 300,
	"grainIntensity":0.08,
}

func saveConfigToDisk(configToSave: Dictionary) -> void:

	var file = FileAccess.open("user://config.json", FileAccess.WRITE)
	file.store_string(JSON.stringify(configToSave, "\t"))
	file.close()
	
func getConfigFromDisk() -> Dictionary:
	if !FileAccess.file_exists("user://config.json"):
		var file = FileAccess.open("user://config.json", FileAccess.WRITE);
		file.store_string(JSON.stringify(DEFAULT_CONFIG, "\t"));
		file.close()
	return JSON.parse_string(FileAccess.open("user://config.json", FileAccess.READ).get_as_text())
	
func effectuate_options(configToEffectuate) -> void:
		# effectuate all option changes
	# GENERAL
	# VHS Effects
	if !configToEffectuate.general.vhs_effects:
		get_tree().root.get_node("Main/Perfect Pixel Effects").hide()
	elif configToEffectuate.general.vhs_effects:
		get_tree().root.get_node("Main/Perfect Pixel Effects").show()
	# VHS Effect Intensity
	get_tree().root.get_node("Main/Perfect Pixel Effects").material.set_shader_parameter("shake", lerp(min_shader_strength.shake, med_shader_strength.shake, configToEffectuate.general.vhs_effects_intensity))
	get_tree().root.get_node("Main/Perfect Pixel Effects").material.set_shader_parameter("noiseQuality", lerp(min_shader_strength.noiseQuality, med_shader_strength.noiseQuality, configToEffectuate.general.vhs_effects_intensity))
	get_tree().root.get_node("Main/Perfect Pixel Effects").material.set_shader_parameter("noiseIntensity", lerp(min_shader_strength.noiseIntensity, med_shader_strength.noiseIntensity, configToEffectuate.general.vhs_effects_intensity))
	get_tree().root.get_node("Main/Perfect Pixel Effects").material.set_shader_parameter("offsetIntensity", lerp(min_shader_strength.offsetIntensity, med_shader_strength.offsetIntensity, configToEffectuate.general.vhs_effects_intensity))
	get_tree().root.get_node("Main/Perfect Pixel Effects").material.set_shader_parameter("grainIntensity", lerp(min_shader_strength.grainIntensity, med_shader_strength.grainIntensity, configToEffectuate.general.vhs_effects_intensity))
	get_tree().root.get_node("Main/Perfect Pixel Effects").material.set_shader_parameter("pixelSize", lerp(min_shader_strength.pixelSize, med_shader_strength.pixelSize, configToEffectuate.general.vhs_effects_intensity))

	# SOUND
	#Mute all Sounds
	if configToEffectuate.sound.mute_all_sounds:
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), -100)
	elif !configToEffectuate.sound.mute_all_sounds:
		# Overall Volume
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear_to_db(configToEffectuate.sound.overall_volume))
		# Ambiance Volume
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Ambiance"), linear_to_db(configToEffectuate.sound.ambiance_volume))
		# SFX Volume
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), linear_to_db(configToEffectuate.sound.sfx_volume))
		# Music Volume
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), linear_to_db(configToEffectuate.sound.music_volume))
		
	# TODO Cycle through the rest of options
	#
	#Brightness
	# Something like this 
	get_tree().root.get_node("Main/Environment/WorldEnvironment").environment.adjustment_brightness = configToEffectuate.display.brightness
	#Fullscreen
	match configToEffectuate.display.display_mode:
		0:
			DisplayServer.window_set_mode(DisplayServer.WindowMode.WINDOW_MODE_FULLSCREEN);
		1:
			DisplayServer.window_set_mode(DisplayServer.WindowMode.WINDOW_MODE_WINDOWED);
	#

	pass # Replace with function body.
