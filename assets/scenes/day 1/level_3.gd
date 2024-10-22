extends Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if get_tree().root.get_node_or_null("Main/player"):
		get_tree().root.get_node("Main").resetPlayer()
	else:
		get_tree().root.get_node("Main").spawnPlayer()
	await get_tree().create_timer(1).timeout

	var clipboard = get_tree().root.get_node("Main/player/Neck/Camera3D/Clipboard Container/Clipboard")
	clipboard.load_text(3)
	
func _on_title_notifier_screen_entered() -> void:
	audio_info.play_click()
	$Title/TitleTimer.start()
	pass # Replace with function body.

func _on_title_timer_timeout() -> void:
	audio_info.play_confirm()
	$Title.queue_free()
	pass # Replace with function body.

func _on_day_timer_timeout() -> void:
	$"Title/Day 1".show()
	$"Containment Chamber/Near Wall/Door/DoorHum".play()
	$"Containment Chamber/Ceiling Light 2/Ceiling Light Hum".play()
	$"Containment Chamber/Ceiling Light/Ceiling Light Hum".play()
	pass # Replace with function body.
