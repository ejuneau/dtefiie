extends Control

signal new_game_pressed
signal options_pressed
signal button_pressed
# Good luck with this one buddy
var saveData

# TODO implement save state data.
func _ready() -> void:
	if saveData:
		$MarginContainer/VSplitContainer/Options/Continue.show()
	pass # Replace with function body.

#
		




# Quit the game
func _on_quit_pressed() -> void:
	get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
	get_tree().quit()

 


func _on_new_game_pressed() -> void:
	new_game_pressed.emit()
	pass # Replace with function body.


func _on_ambiance_finished() -> void:
	#$Ambiance.play()
	pass # Replace with function body.


func _on_button_pressed() -> void:
	options_pressed.emit()
	button_pressed.emit()
	pass # Replace with function body.
