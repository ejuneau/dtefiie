extends Control

signal exitOptions

#TODO extract these options from config file

@export_category("Default Options")
@export_group("General")
@export var VHSEffectsEnable: bool = true
@export_range(0, 100, 5) var VHSEffectsIntensity: int = 50

@export_group("Sound")
@export var muteAllSounds: bool = false
@export_range(0, 100, 5) var overallVolume: int = 50
@export_range(0, 100, 5) var SFXVolume: int = 50
@export_range(0, 100, 5) var ambianceVolume: int = 50

@export_group("Display")
#@export var muteAllSounds: bool = false
#@export_range(0, 100, 5) var overallVolume: int = 50
#@export_range(0, 100, 5) var SFXVolume: int = 50
#@export_range(0, 100, 5) var ambianceVolume: int = 50

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	#set first tab to visible
	$VSplit/TabContainer/General.show()
	
	# Set all options to default settings
	$"VSplit/TabContainer/General/VHS Effects Container/VHS Effects".button_pressed = VHSEffectsEnable
	$"VSplit/TabContainer/General/VHS Effect Intensity".value = VHSEffectsIntensity
	
	$"VSplit/TabContainer/Sound/Mute All Sounds Container/Mute All Sounds".button_pressed = muteAllSounds
	$"VSplit/TabContainer/Sound/Overall Volume".value = overallVolume
	$"VSplit/TabContainer/Sound/SFX Volume".value = SFXVolume
	$"VSplit/TabContainer/Sound/SFX Volume".value = ambianceVolume
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
		
	# if valueChanged: $Back.hide()
	
	pass



func _on_back_pressed() -> void:
	exitOptions.emit()
	hide()
	pass # Replace with function body.


func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	$VSplit/TabContainer/General.show()
	pass # Replace with function body.
