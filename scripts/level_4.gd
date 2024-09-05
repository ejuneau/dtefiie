extends Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_title_notifier_screen_entered() -> void:
	$Title/TitleTimer.start()
	pass # Replace with function body.

func _on_title_timer_timeout() -> void:
	$ClickPlayer.play()
	$TextEdit.show()
	$Title.queue_free()
	pass # Replace with function body.

func _on_day_timer_timeout() -> void:
	$"Title/Day 1".show()
	$"Containment Chamber/Near Wall/Door/DoorHum".play()
	$"Containment Chamber/Ceiling Light 2/Ceiling Light Hum".play()
	$"Containment Chamber/Ceiling Light/Ceiling Light Hum".play()
	pass # Replace with function body.
