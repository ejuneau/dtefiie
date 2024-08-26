extends Control

@export var randomStrength: float = 30.0
@export var shakeFade: float = 5.0

var rng = RandomNumberGenerator.new()
	
var shake_strength: float = 0.0


var YN
var currentPage

signal load_level1


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func apply_shake():
	shake_strength = randomStrength

func randomOffset() -> Vector2:
	return Vector2(rng.randf_range(-shake_strength,shake_strength), rng.randf_range(-shake_strength,shake_strength))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if shake_strength > 0:
		shake_strength = lerpf(shake_strength,0,shakeFade * delta)
		position = randomOffset()
	
	if Input.is_action_just_pressed("select"):
		$"confirm player".play()
		if YN == "false":
			if currentPage == 1:
				$"Page 1/HSplitContainer/No Ensemble/CenterContainer3/NoTickContainer/No Tick".hide()
				$"Page 1_5".show()
				$"error player".play()
			elif currentPage == 2:
				$"Page 2/HSplitContainer/No Ensemble/CenterContainer3/NoTickContainer/No Tick".hide()
				$"Page 2_5".show()
				$"error player".play()
			elif currentPage == 3:
				$"Page 3/HSplitContainer/No Ensemble/CenterContainer3/NoTickContainer/No Tick".hide()
				$"Page 3_5".show()
				$"error player".play()
			YN = ""
		elif YN == "true":
			
			if currentPage == 1:
				$"Page 1".hide()
				$"Page 2".show()
				YN = ""
			elif currentPage == 2:
				$"Page 2".hide()
				$"Page 3".show()
				YN = ""
			elif currentPage == 3:
				#$"Page 3".hide()
				#$"Page 4".show()
				#YN = ""
				#var level1 = load("res://level1.tscn").instantiate()
				#level1.set_name("level1")
				#get_tree().root.get_node("Main").add_child(level1)
				#
				#var player = load("res://player.tscn").instantiate()
				#player.set_name("player")
				#get_tree().root.get_node("Main").add_child(player)
				load_level1.emit()
				
				get_tree().root.get_node("Main/Pause screen/Ambiance").set_process_mode(3)
				Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
				self.queue_free()
				pass
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("mark_too_big"):
		YN = "true"
		$"clicks player".play()
	elif event.is_action_pressed("mark_not_too_big"):
		YN = "false"
		$"clicks player".play()


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
	$"confirm player".play()
	pass # Replace with function body.


func _on_page_2_notifier_screen_entered() -> void:
	currentPage = 2
	pass # Replace with function body.


func _on_page_3_notifier_screen_entered() -> void:
	currentPage = 3
	pass # Replace with function body.





#func _on_timer_timeout() -> void:
	#$"Page 4/Timer".stop()
	#var level1 = load("res://level1.tscn")
	#var level1_instance = level1.instantiate()
	#level1_instance.set_name("level1")
	#get_tree().root.get_node("Main").add_child(level1_instance)
	#get_tree().root.get_node("Main/Pause screen/Ambiance").set_process_mode(3)
	#Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	#self.queue_free()
	


func _on_page_1_5_notifier_screen_entered() -> void:
	$"Page 1_5/Page1_5Timer".start()
	apply_shake()
	

	pass # Replace with function body.


func _on_page_1_5_timer_timeout() -> void:
	$"Page 1_5".hide()
	pass # Replace with function body.
	


func _on_page_2_5_notifier_screen_entered() -> void:
	$"Page 2_5/Page2_5Timer".start()
	apply_shake()
	pass # Replace with function body.


func _on_page_2_5_timer_timeout() -> void:
	$"Page 2_5".hide()
	pass # Replace with function body.


func _on_page_3_5_notifier_screen_entered() -> void:
	$"Page 3_5/Page3_5Timer".start()
	apply_shake()
	pass # Replace with function body.


func _on_page_3_5_timer_timeout() -> void:
	$"Page 3_5".hide()
	pass # Replace with function body.


func _on_ambiance_finished() -> void:
	$Ambiance.play()
	pass # Replace with function body.
