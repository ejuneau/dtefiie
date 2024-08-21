extends Control

signal new_game_pressed
# Good luck with this one buddy
var saveData

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if saveData:
		$MarginContainer/VSplitContainer/Options/Continue.show()
	pass # Replace with function body.

#
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass


# Quit the game
func _on_quit_pressed() -> void:
	get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
	get_tree().quit()


func _on_options_pressed() -> void:
	$"MarginContainer/VSplitContainer/Options/WIP label".show()


func _on_new_game_pressed() -> void:
	new_game_pressed.emit()
	pass # Replace with function body.
