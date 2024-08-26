extends Control

var isPaused: bool = false

signal paused
signal unpaused

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

#func _unhandled_input(event) -> void:
	#if event is InputEventMouseButton:
		#Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	#elif event.is_action_pressed("ui_cancel"):
		#Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
func _unhandled_input(event) -> void:
	if event.is_action_pressed("ui_cancel"):
		isPaused = !isPaused
		if isPaused:
			
			paused.emit()
		elif !isPaused:
			unpaused.emit()
			
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass
	
func _on_paused() -> void:
	get_tree().paused = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	show()
	isPaused = true
	$Ambiance.play()
	$"Click Player".play()
	pass

func _on_unpaused() -> void:
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	hide()
	isPaused = false
	$Ambiance.stop()
	$"Confirm Player".play()

	pass

# Quit the game
func _on_quit_pressed() -> void:
	get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
	get_tree().quit()


func _on_options_pressed() -> void:
	$"MarginContainer/VSplitContainer/Options/WIP label".show()


func _on_ambiance_finished() -> void:
	$Ambiance.play()
	pass # Replace with function body.
