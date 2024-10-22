extends Control

var isPaused: bool = false

signal unpaused
signal showOptions
signal hideOptions
signal optionsSaved
signal newSettings

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

#func _unhandled_input(event) -> void:
	#if event.is_action_pressed("ui_cancel"):
		#isPaused = !isPaused
		#if isPaused:
			#
			#paused.emit()
		#elif !isPaused:
			#unpaused.emit()
			
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass
	
#func _on_paused() -> void:
	#get_tree().paused = true
	#Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	#show()
	#isPaused = true
	#$Ambiance.play()
	#$"Click Player".play()
	#pass
#
#func _on_unpaused() -> void:
	#get_tree().paused = false
	#Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	#hide()
	#isPaused = false
	#$Ambiance.stop()
	#$"Confirm Player".play()

	pass

# Quit the game
func _on_quit_pressed() -> void:
	get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
	get_tree().quit()


func _on_options_pressed() -> void:
	showOptions.emit()

func _on_ambiance_finished() -> void:
	#$Ambiance.play()
	pass # Replace with function body.


func _on_options_menu_exit_options() -> void:
	hideOptions.emit()
	pass # Replace with function body.


func _on_resume_pressed() -> void:
	unpaused.emit()
	pass # Replace with function body.


func _on_options_menu_options_saved() -> void:
	optionsSaved.emit()
	pass # Replace with function body.


func _on_click_pressed() -> void:
	audio_info.play_click()
	pass # Replace with function body.


func _on_error_pressed() -> void:
	audio_info.play_error()
	pass # Replace with function body.


func _on_confirm_pressed() -> void:
	audio_info.play_confirm()
	pass # Replace with function body.


func _on_new_settings() -> void:
	newSettings.emit()
	pass # Replace with function body.
