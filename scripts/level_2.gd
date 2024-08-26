extends Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_player_clipboard_answer_confirmed(answer: bool) -> void:
	if answer: #load level2
		var level3 = load("res://level3.tscn")
		var level3_instance = level3.instantiate()
		level3_instance.set_name("level3")
		get_tree().root.get_node("Main").add_child(level3_instance)
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		self.queue_free()
	elif !answer: #restart level1
		get_tree().reload_current_scene()
	pass # Replace with function body.


func _on_title_notifier_screen_entered() -> void:
	$Title/TitleTimer.start()
	pass # Replace with function body.


func _on_title_timer_timeout() -> void:
	$Title.queue_free()
	pass # Replace with function body.


func _on_day_timer_timeout() -> void:
	$"Title/Day 1".show()
	pass # Replace with function body.
