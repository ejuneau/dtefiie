extends Control

signal new_game_pressed
signal options_pressed
signal button_pressed
# Good luck with this one buddy
var saveData

# TODO implement save state data.
func _ready() -> void:
	#save_info.saveProgressToDisk(save_info.PLACEHOLDER_SAVE_DATA)
	pass

#
func _process(_delta):
	if save_info.save_data_exists():
		$"MarginContainer/Main Menu/Options/Continue".show()
		$"MarginContainer/Main Menu/Options/New Game".hide()
	else:
		$"MarginContainer/Main Menu/Options/Continue".hide()
		$"MarginContainer/Main Menu/Options/New Game".show()




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
	button_pressed.emit()
	pass # Replace with function body.


func _on_credits_back_pressed() -> void:
	$Credits.hide()
	pass # Replace with function body.


func _on_show_credits_pressed() -> void:
	$Credits.show()
	pass # Replace with function body.


func _on_options_pressed() -> void:
	options_pressed.emit()
	pass # Replace with function body.


func _on_continue_pressed() -> void:
	
	level_info.load_level(save_info.get_next_level())
	get_tree().root.get_node("Main/Pause screen/Pause Screen Margin/Options Menu/VSplit/TabContainer/General/Delete All Save Data").disabled = true

	pass # Replace with function body.
