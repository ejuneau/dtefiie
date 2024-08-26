extends Node3D

signal clipboard_raised
signal clipboard_lowered
signal answerConfirmed(answer:bool)


var targetUpDown = false # false: target is clipboard down, true: target is clipboard up
var isMoving = false

var isTooBig

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("clipboard"):
		targetUpDown = !targetUpDown # Toggles if target should be up or down

			
		

		if targetUpDown: # Animations for if the clipboard should be up
			if !isMoving: # if the clipboard was not moving prior (meaning was down)
				isMoving = true
				$MeshInstance3D/AnimationPlayer.play("Hold Up")
			elif isMoving: # if the clipboard was moving (cancelled from lowering)
				$MeshInstance3D/AnimationPlayer.play_backwards("Put Back")
		elif !targetUpDown: # Animations for if the clipboard should be lowered
			if !isMoving: #if the clipboard was not moving prior (meaning it was up)
				isMoving = true
				$MeshInstance3D/AnimationPlayer.play("Put Back")
			elif isMoving: # if the clipboard was moving (cancelled from raising)
				$MeshInstance3D/AnimationPlayer.play_backwards("Hold Up")


	if targetUpDown: # Only allow selections if clipboard is up
		if event.is_action_pressed("mark_too_big"):
			isTooBig = "true"
			$"scribble player".play()
		elif event.is_action_pressed("mark_not_too_big"):
			isTooBig = "false"
			$"scribble player".play()
			
			
		if isTooBig == "true":
			$"MeshInstance3D/Assessment/Yes Box/Yes Tick".show()
			$"MeshInstance3D/Assessment/No Box/No Tick".hide()
		elif isTooBig == "false":
			$"MeshInstance3D/Assessment/No Box/No Tick".show()
			$"MeshInstance3D/Assessment/Yes Box/Yes Tick".hide()
			
	if event.is_action_pressed("select"):
		if isTooBig == "true": # only send signals if an answer is marked
			answerConfirmed.emit(true)
		elif isTooBig == "false":
			answerConfirmed.emit(false)


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if  anim_name == "Hold Up":
		isMoving = false
		clipboard_raised.emit()
		
	elif anim_name == "Put Back":
		isMoving = false
		clipboard_lowered.emit()
	pass # Replace with function body.
