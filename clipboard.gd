extends Node3D

signal clipboard_raised
signal clipboard_lowered

var isClipboardUp = false

var isTooBig

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("clipboard"):
		isClipboardUp = !isClipboardUp
		
		if isClipboardUp:
			$MeshInstance3D/AnimationPlayer.play("Hold Up")
			clipboard_raised.emit()
		elif not isClipboardUp:
			$MeshInstance3D/AnimationPlayer.play("Put Back")
			clipboard_lowered.emit()

	if isClipboardUp:
		if event.is_action_pressed("mark_too_big"):
			isTooBig = "true"
		elif event.is_action_pressed("mark_not_too_big"):
			isTooBig = "false"
			
			
		if isTooBig == "true":
			$"MeshInstance3D/Assessment/Yes Box/Yes Tick".show()
			$"MeshInstance3D/Assessment/No Box/No Tick".hide()
		elif isTooBig == "false":
			$"MeshInstance3D/Assessment/No Box/No Tick".show()
			$"MeshInstance3D/Assessment/Yes Box/Yes Tick".hide()
