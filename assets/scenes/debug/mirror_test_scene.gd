extends Node3D

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE;
		else:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED;
			
	if Input.is_action_just_pressed("select"):
		$"Mirror/Mirror Frame".visible = !$"Mirror/Mirror Frame".visible
		
	if Input.is_action_just_pressed("mark_too_big"):
		$"Mirror/SubViewport/Camera3D".fov += 1;
	if Input.is_action_just_pressed("mark_not_too_big"):
		$"Mirror/SubViewport/Camera3D".fov -= 1;
