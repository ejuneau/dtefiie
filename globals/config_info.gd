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
		"sfx_volume": 5
	}
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
