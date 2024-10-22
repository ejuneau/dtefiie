extends Control

signal exitOptions
signal optionsSaved
signal newSettings

#TODO extract these options from config file

#access config and save as variable
var configFromDisk = config_info.getConfigFromDisk()
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



@onready var general: Control = $VSplit/TabContainer/General
@onready var vhs_effects: CheckBox = $"VSplit/TabContainer/General/MarginContainer/VBoxContainer/VHS Effects Container/VHS Effects"
@onready var vhs_effect_intensity: HSlider = $"VSplit/TabContainer/General/MarginContainer/VBoxContainer/VBoxContainer/VHS Effect Intensity"

#@onready var sound: Control = $VSplit/TabContainer/Sound
@onready var mute_all_sounds: CheckBox = $"VSplit/TabContainer/Sound/MarginContainer/VBoxContainer/Mute All Sounds Container/Mute All Sounds"
@onready var overall_volume: HSlider = $"VSplit/TabContainer/Sound/MarginContainer/VBoxContainer/Overall Volume Container/Overall Volume"
@onready var music_volume: HSlider = $"VSplit/TabContainer/Sound/MarginContainer/VBoxContainer/Music Volume Container/Music Volume"
@onready var ambiance_volume: HSlider = $"VSplit/TabContainer/Sound/MarginContainer/VBoxContainer/Ambiance Volume Container/Ambiance Volume"
@onready var sfx_volume: HSlider = $"VSplit/TabContainer/Sound/MarginContainer/VBoxContainer/SFX Volume Container/SFX Volume"

@onready var display_mode: OptionButton = $"VSplit/TabContainer/Display/MarginContainer/VBoxContainer/VBoxContainer2/Display Mode"
@onready var brightness: HSlider = $VSplit/TabContainer/Display/MarginContainer/VBoxContainer/VBoxContainer/Brightness

var currentConfig = configFromDisk

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
	audio_info.play_click()
	exitOptions.emit()
	hide()
	pass # Replace with function body.


func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	general.show()
	pass # Replace with function body.

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
	"ambiance_volume": ambiance_volume.value,
	"music_volume": music_volume.value
  },
  "display": {
	"brightness": brightness.value,
	"display_mode": display_mode.selected
  }
}


func _on_options_changed(_option) -> void:
	audio_info.play_click()
	$Back.hide()
	newSettings.emit()
	pass # Replace with function body.
	
func set_all_options(configToSet) -> void:
	vhs_effects.button_pressed = configToSet.general.vhs_effects
	vhs_effect_intensity.value = configToSet.general.vhs_effects_intensity
	
	mute_all_sounds.button_pressed = configToSet.sound.mute_all_sounds
	overall_volume.value = configToSet.sound.overall_volume
	ambiance_volume.value = configToSet.sound.ambiance_volume
	sfx_volume.value = configToSet.sound.sfx_volume
	music_volume.value = configToSet.sound.music_volume
	
	display_mode.selected = configToSet.display.display_mode
	brightness.value = configToSet.display.brightness

func _on_discard_pressed() -> void:
	set_all_options(currentConfig)
	audio_info.play_error()
	newSettings.emit()
	$Back.show()
	pass # Replace with function body.




func _on_save_pressed() -> void:
	config_info.saveConfigToDisk(getConfigFromOptions())
	optionsSaved.emit()
	audio_info.play_confirm()
	$Back.show()
	pass # Replace with function body.



func _on_defaults_pressed() -> void:
	set_all_options(config_info.DEFAULT_CONFIG)
	config_info.saveConfigToDisk(config_info.DEFAULT_CONFIG)
	optionsSaved.emit()
	audio_info.play_error()
	$Back.show()
	pass # Replace with function body.


func _on_tab_container_tab_changed(_tab: int) -> void:
	audio_info.play_click()
	pass # Replace with function body.




func _on_display_mode_pressed() -> void:
	audio_info.play_click()
	pass # Replace with function body.
