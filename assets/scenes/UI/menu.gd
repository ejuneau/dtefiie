extends Control

signal new_game_pressed
signal continue_pressed
signal options_pressed

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
	audio_info.play_click()
	pass # Replace with function body.


func _on_credits_back_pressed() -> void:
	$Credits.hide()
	$MarginContainer.show()

	pass # Replace with function body.


func _on_show_credits_pressed() -> void:
	$Credits.show()
	pass # Replace with function body.


func _on_options_pressed() -> void:
	options_pressed.emit()
	pass # Replace with function body.


func _on_continue_pressed() -> void:
	continue_pressed.emit()
	level_info.load_level(save_info.get_next_level())
	get_tree().root.get_node("Main/Pause screen/Pause Screen Margin/Options Menu/VSplit/TabContainer/General/MarginContainer/VBoxContainer/Delete All Save Data").disabled = true

	pass # Replace with function body.


func _on_menu_music_player_finished() -> void:
	$"Menu Music Player".play()
	pass # Replace with function body.


func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	$MarginContainer.hide()
	pass # Replace with function body.
