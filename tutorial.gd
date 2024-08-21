extends Control

var YN
var currentPage

signal loadLevel1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("select"):
		if YN == "false":
			if currentPage == 1:
				$"Page 1/HSplitContainer/No Ensemble/CenterContainer3/NoTickContainer/No Tick".hide()
			if currentPage == 2:
				$"Page 2/HSplitContainer/No Ensemble/CenterContainer3/NoTickContainer/No Tick".hide()
			if currentPage == 3:
				$"Page 3/HSplitContainer/No Ensemble/CenterContainer3/NoTickContainer/No Tick".hide()
			YN = ""
		elif YN == "true":
			if currentPage == 1:
				$"Page 1".hide()
				$"Page 2".show()
				YN = ""
			if currentPage == 2:
				$"Page 2".hide()
				$"Page 3".show()
				YN = ""
			if currentPage == 3:
				$"Page 3".hide()
				$"Page 4".show()
				YN = ""
	pass
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("mark_too_big"):
		YN = "true"
	elif event.is_action_pressed("mark_not_too_big"):
		YN = "false"


	if YN == "true":
		if currentPage == 1:
			$"Page 1/HSplitContainer/Yes Ensemble/CenterContainer3/YesTickContainer/Yes Tick".show()
			$"Page 1/HSplitContainer/No Ensemble/CenterContainer3/NoTickContainer/No Tick".hide()
		elif currentPage == 2:
			$"Page 2/HSplitContainer/Yes Ensemble/CenterContainer3/YesTickContainer/Yes Tick".show()
			$"Page 2/HSplitContainer/No Ensemble/CenterContainer3/NoTickContainer/No Tick".hide()
		elif currentPage == 3:
			$"Page 3/HSplitContainer/Yes Ensemble/CenterContainer3/YesTickContainer/Yes Tick".show()
			$"Page 3/HSplitContainer/No Ensemble/CenterContainer3/NoTickContainer/No Tick".hide()

		
	elif YN == "false":
		if currentPage == 1:
			$"Page 1/HSplitContainer/Yes Ensemble/CenterContainer3/YesTickContainer/Yes Tick".hide()
			$"Page 1/HSplitContainer/No Ensemble/CenterContainer3/NoTickContainer/No Tick".show()
		elif currentPage == 2:
			$"Page 2/HSplitContainer/Yes Ensemble/CenterContainer3/YesTickContainer/Yes Tick".hide()
			$"Page 2/HSplitContainer/No Ensemble/CenterContainer3/NoTickContainer/No Tick".show()
		elif currentPage == 3:
			$"Page 3/HSplitContainer/Yes Ensemble/CenterContainer3/YesTickContainer/Yes Tick".hide()
			$"Page 3/HSplitContainer/No Ensemble/CenterContainer3/NoTickContainer/No Tick".show()
		



func _on_page_1_notifier_screen_entered() -> void:
	currentPage = 1
	pass # Replace with function body.


func _on_page_2_notifier_screen_entered() -> void:
	currentPage = 2
	pass # Replace with function body.


func _on_page_3_notifier_screen_entered() -> void:
	currentPage = 3
	pass # Replace with function body.


func _on_page_4_notifier_screen_entered() -> void:
	currentPage = 4
	$"Page 4/Timer".start()
	pass # Replace with function body.


func _on_timer_timeout() -> void:
	$"Page 4/Timer".stop()
	var level1 = load("res://level1.tscn")
	var level1_instance = level1.instantiate()
	level1_instance.set_name("level1")
	get_tree().root.get_node("Main").add_child(level1_instance)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	self.queue_free()
	
