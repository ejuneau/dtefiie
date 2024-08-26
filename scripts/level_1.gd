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
	$Title.queue_free()
	pass # Replace with function body.


func _on_day_timer_timeout() -> void:
	$"Title/Day 1".show()
	pass # Replace with function body.
