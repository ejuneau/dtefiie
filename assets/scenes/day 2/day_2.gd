extends Control

var YN
@onready var yes_tick: Label = $"Overlay/Yes Tick"
@onready var no_tick: Label = $"Overlay/No Tick"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	var assessmentArray = save_info.get_correct_assessments_day(1)
	$"Overlay/MarginContainer/Vboxcontainer/Vboxcontainer/Previous Day Assessments/CHANGETHISVALUE (DAY)".text = (str(assessmentArray[0]) +" / "+str(assessmentArray[1]) )
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("select"):
		if YN:
			audio_info.play_confirm()
			self.queue_free()
			#loadLevel1.emit()
			level_info.load_level([2, 1])


func _unhandled_input(event: InputEvent) -> void:

	if event.is_action_pressed("mark_too_big"):
		YN = "true"
	elif event.is_action_pressed("mark_not_too_big"):
		YN = "false"
	audio_info.play_click()

	if YN == "true":
		yes_tick.show()
		no_tick.hide()
	
	elif YN == "false":
		yes_tick.hide()
		no_tick.show()
		
func _on_title_notifier_screen_entered() -> void:
	audio_info.play_click()
	$Title/TitleTimer.start()
	pass # Replace with function body.

func _on_title_timer_timeout() -> void:
	audio_info.play_confirm()
	$Overlay.show()
	$Title.queue_free()
	pass # Replace with function body.
