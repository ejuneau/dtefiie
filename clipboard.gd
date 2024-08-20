extends Node3D

signal clipboard_raised
signal clipboard_lowered

var isClipboardUp = false

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("clipboard"):
		isClipboardUp = !isClipboardUp
		
		if isClipboardUp:
			$MeshInstance3D/AnimationPlayer.play("Hold Up")
			clipboard_raised.emit()
		elif not isClipboardUp:
			$MeshInstance3D/AnimationPlayer.play("Put Back")
			clipboard_lowered.emit()
