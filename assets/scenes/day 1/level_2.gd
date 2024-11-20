extends Node

var isFirstLook: bool = true
var isSkullVisible: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if get_tree().root.get_node_or_null("Main/player"):
		get_tree().root.get_node("Main").resetPlayer()
	else:
		get_tree().root.get_node("Main").spawnPlayer()
	await get_tree().create_timer(1).timeout

	var clipboard = get_tree().root.get_node("Main/player/Neck/Camera3D/Clipboard Container/Clipboard")
	clipboard.load_text(2)
	
func _process(_delta: float) -> void:
	if get_tree().root.get_node_or_null("Main/player"):
		$SkullCam.look_at(get_tree().root.get_node_or_null("Main/player").get_global_position())
		$SkullCam/Skull.visible = isSkullVisible
		
func _on_title_notifier_screen_entered() -> void:
	audio_info.play_click()
	$Title/TitleTimer.start()
	pass # Replace with function body.

func _on_title_timer_timeout() -> void:
	audio_info.play_confirm()
	$Title.queue_free()
	$VisibleOnScreenNotifier3D.set_process_mode(PROCESS_MODE_INHERIT)
	$VisibleOnScreenNotifier3D.show()
	pass # Replace with function body.

func _on_day_timer_timeout() -> void:
	$"Title/Day 1".show()
	$"Containment Chamber/Near Wall/Door/DoorHum".play()
	$"Containment Chamber/Ceiling Light 2/Ceiling Light Hum".play()
	$"Containment Chamber/Ceiling Light/Ceiling Light Hum".play()
	pass # Replace with function body.


func _on_visible_on_screen_notifier_3d_screen_entered() -> void:
	if !$VisibleOnScreenNotifier3D2.is_on_screen():
		if isFirstLook:
			$"Containment Chamber (Mirror)/Flames".show()
			$AnimationPlayer.play("Deer (merge)")
			$"Containment Chamber (Mirror)/Flames".emitting = true
			isFirstLook = false
			isSkullVisible = true
			$"Audio/Deer (idle)".set_process_mode(Node.PROCESS_MODE_DISABLED)
			$"Audio/Deer (Splat)".play()
	else:
		$AnimationPlayer.play("RESET")
		$"Containment Chamber (Mirror)/Flames".emitting = false
		$"Containment Chamber (Mirror)/Flames".hide()
		isSkullVisible = false
		$"Audio/Deer (idle)".set_process_mode(Node.PROCESS_MODE_INHERIT)





func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Deer (merge)":
		$AnimationPlayer.play("Deer (merged)")


func _on_visible_on_screen_notifier_3d_screen_exited() -> void:
	$"Containment Chamber (Mirror)/Flames".hide()
	$AnimationPlayer.play("RESET")
	$"Containment Chamber (Mirror)/Flames".emitting = false
	isSkullVisible = false
	$"Audio/Deer (idle)".set_process_mode(Node.PROCESS_MODE_INHERIT)
	$"Audio/Deer (Splat)".stop()



func _on_deer_timer_timeout() -> void:
	$"Audio/Deer (idle)".play()
	$"Deer Timer".start(RandomNumberGenerator.new().randf_range(2.0, 8.0))
	pass # Replace with function body.
