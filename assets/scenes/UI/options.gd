extends Control

signal exitOptions
signal optionsSaved
signal click_pressed
signal error_pressed
signal confirm_pressed
signal new_settings

#TODO extract these options from config file

#access config and save as variable
var configFromDisk = getConfigFromDisk
#@export_category("Default Options")
#@export_group("General")
#@export var VHSEffectsEnable: bool = config.general.vhs_effects
#@export_range(0, 100, 5) var VHSEffectsIntensity: int = config.general.vhs_effects_intensity
#
#@export_group("Sound")
#@export var muteAllSounds: bool = config.sound.mute_all_sounds
#@export_range(0, 100, 5) var overallVolume: int = config.sound.overall_volume
#@export_range(0, 100, 5) var SFXVolume: int = config.sound.sfx_volume
#@export_range(0, 100, 5) var ambianceVolume: int = config.sound.ambiance_volume
#
#@export_group("Display")
#@export var fullscreen: bool = config.display.fullscreen
#@export_range(0, 100, 5) var brightness: int = config.display.brightness
#@export_range(0, 100, 5) var overallVolume: int = 50
#@export_range(0, 100, 5) var SFXVolume: int = 50
#@export_range(0, 100, 5) var ambianceVolume: int = 50

# Called when the node enters the scene tree for the first time.

var DEFAULT_CONFIG = {
	"display": {
		"brightness": 50,
		"fullscreen": false
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


@onready var general: Control = $VSplit/TabContainer/General
@onready var vhs_effects: CheckBox = $"VSplit/TabContainer/General/MarginContainer/VBoxContainer/VHS Effects Container/VHS Effects"
@onready var vhs_effect_intensity: HSlider = $"VSplit/TabContainer/General/MarginContainer/VBoxContainer/VHS Effect Intensity"
@onready var sound: Control = $VSplit/TabContainer/Sound
@onready var mute_all_sounds: CheckBox = $"VSplit/TabContainer/Sound/MarginContainer/VBoxContainer/Mute All Sounds Container/Mute All Sounds"
@onready var sfx_volume: HSlider = $"VSplit/TabContainer/Sound/MarginContainer/VBoxContainer/SFX Volume"
@onready var ambiance_volume: HSlider = $"VSplit/TabContainer/Sound/MarginContainer/VBoxContainer/Ambiance Volume"
@onready var overall_volume: HSlider = $"VSplit/TabContainer/Sound/MarginContainer/VBoxContainer/Overall Volume"

var currentConfig = getConfigFromDisk()

func _ready() -> void:
	
	#set first tab to visible
	general.show()
	
	# Set all options to default settings from disk
	set_all_options(currentConfig)
	$Back.show()

	
	# Check if an options file exists, if not makes one
	# Creates temporary new options file
	# if any value is changed, log values in temp file, hide Back button and show Save/Discard 
	# on confirmation, commit temp file values to options file
	# on discard, delete contents of temp file
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if $Back.is_visible_in_tree() :
		$Save.hide()
		$Discard.hide()
	elif !$Back.is_visible_in_tree() :
		$Save.show()
		$Discard.show()



func _on_back_pressed() -> void:
	exitOptions.emit()
	hide()
	pass # Replace with function body.


func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	general.show()
	pass # Replace with function body.

func saveConfigToDisk(configToSave: Dictionary) -> void:

	var file = FileAccess.open("res://config.json", FileAccess.WRITE)
	file.store_string(JSON.stringify(configToSave, "\t"))
	file.close()
	
func getConfigFromDisk() -> Dictionary:
	return JSON.parse_string(FileAccess.open("res://config.json", FileAccess.READ).get_as_text())

func getConfigFromOptions() -> Dictionary:
	return {
  "general": {
	"vhs_effects": vhs_effects.button_pressed,
	"vhs_effects_intensity": vhs_effect_intensity.value

  },
  "sound": {
	"mute_all_sounds": mute_all_sounds.button_pressed,
	"overall_volume": overall_volume.value,
	"sfx_volume": sfx_volume.value,
	"ambiance_volume": ambiance_volume.value
  },
  "display": {
	"brightness": 50,
	"fullscreen": false
  }
}


func _on_options_changed(_option) -> void:
	$Back.hide()
	new_settings.emit()
	pass # Replace with function body.
	
func set_all_options(configToSet) -> void:
	vhs_effects.button_pressed = configToSet.general.vhs_effects
	vhs_effect_intensity.value = configToSet.general.vhs_effects_intensity
	
	mute_all_sounds.button_pressed = configToSet.sound.mute_all_sounds
	overall_volume.value = configToSet.sound.overall_volume
	ambiance_volume.value = configToSet.sound.ambiance_volume
	sfx_volume.value = configToSet.sound.sfx_volume

func _on_discard_pressed() -> void:
	set_all_options(currentConfig)
	new_settings.emit()
	$Back.show()
	pass # Replace with function body.




func _on_save_pressed() -> void:
	saveConfigToDisk(getConfigFromOptions())
	optionsSaved.emit()
	confirm_pressed.emit()
	$Back.show()
	pass # Replace with function body.


func _on_click_pressed() -> void:
	click_pressed.emit()
	pass # Replace with function body.


func _on_error_pressed() -> void:
	error_pressed.emit()
	pass # Replace with function body.


func _on_defaults_pressed() -> void:
	set_all_options(DEFAULT_CONFIG)
	saveConfigToDisk(DEFAULT_CONFIG)
	optionsSaved.emit()
	error_pressed.emit()
	$Back.show()
	pass # Replace with function body.
