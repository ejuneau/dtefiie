extends Control

signal exitOptions
signal optionsSaved

#TODO extract these options from config file

#access config and save as variable
var config = loadOptions
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
  "general": {
	"vhs_effects": true,
	"vhs_effects_intensity": 50

  },
  "sound": {
	"mute_all_sounds": false,
	"overall_volume": 10,
	"sfx_volume": 10,
	"ambiance_volume": 10
  },
  "display": {
	"brightness": 10,
	"fullscreen": false
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

var currentConfig = loadOptions()

func _ready() -> void:
	
	#set first tab to visible
	general.show()
	
	# Set all options to default settings
	set_all_options(currentConfig)
	$Back.show()

	
	# Check if an options file exists, if not makes one
	# Creates temporary new options file
	# if any value is chagned, log values in temp file, hide Back button and show Save/Discard 
	# on confirmation, commit temp file values to options file
	# on discard, delete contents of temp file
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if $Back.is_visible_in_tree() :
		$Save.hide()
		$Discard.hide()
	elif !$Back.is_visible_in_tree() :
		$Save.show()
		$Discard.show()
		

	pass



func _on_back_pressed() -> void:
	exitOptions.emit()
	hide()
	pass # Replace with function body.


func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	general.show()
	pass # Replace with function body.

func saveOptions() -> void:
	var newConfigDict = {
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
	var file = FileAccess.open("res://config.json", FileAccess.WRITE)
	file.store_string(JSON.stringify(newConfigDict, "\t"))
	file.close()
	
func loadOptions() -> Dictionary:
	#var file = FileAccess.open("res://config.json", FileAccess.READ)
	#var config = JSON.parse_string(file.get_as_text())

	
	return JSON.parse_string(FileAccess.open("res://config.json", FileAccess.READ).get_as_text())
	#return config


func _on_options_changed(option) -> void:
	$Back.hide()
	pass # Replace with function body.
	
func set_all_options(config) -> void:
	vhs_effects.button_pressed = config.general.vhs_effects
	vhs_effect_intensity.value = config.general.vhs_effects_intensity
	
	mute_all_sounds.button_pressed = config.sound.mute_all_sounds
	overall_volume.value = config.sound.overall_volume
	ambiance_volume.value = config.sound.ambiance_volume
	sfx_volume.value = config.sound.sfx_volume

func reset_options() -> void:
	set_all_options(DEFAULT_CONFIG)


func _on_discard_pressed() -> void:
	set_all_options(currentConfig)
	$Back.show()
	pass # Replace with function body.




func _on_save_pressed() -> void:
	saveOptions()
	optionsSaved.emit()
	$Back.show()
	pass # Replace with function body.
