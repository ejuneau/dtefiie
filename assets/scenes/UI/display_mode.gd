extends OptionButton

var popup

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.selected = config_info.getConfigFromDisk().display.display_mode
	popup = get_popup()
	var popupTheme = load("res://assets/themes/pause_screen.tres")
	popup.set_theme(popupTheme)
	pass # Replace with function body.
