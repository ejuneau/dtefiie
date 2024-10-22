extends Control

@export var randomStrength: float = 30.0
@export var shakeFade: float = 5.0

var rng = RandomNumberGenerator.new()
	
var shake_strength: float = 0.0


var YN
var currentPage



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
		audio_info.play_confirm()
		if YN == "false":
			showError(currentPage)
		elif YN == "true":
			loadNextPage(currentPage)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("mark_too_big"):
		YN = "true"
	elif event.is_action_pressed("mark_not_too_big"):
		YN = "false"
	audio_info.play_click()


	if YN == "true":
		markYes(currentPage)

	elif YN == "false":
		markNo(currentPage)

		



func _on_page_1_notifier_screen_entered() -> void:
	currentPage = 1
	audio_info.play_confirm()
	pass # Replace with function body.


func _on_page_2_notifier_screen_entered() -> void:
	currentPage = 2
	pass # Replace with function body.


func _on_page_3_notifier_screen_entered() -> void:
	currentPage = 3
	pass # Replace with function body.

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
	
func showError(page) -> void:
	get_node("Page "+str(page)+"_5").show()
	$"Page 1/HSplitContainer/No Ensemble/CenterContainer3/NoTickContainer/No Tick".hide()
	get_node("Page "+str(page)+"/HSplitContainer/No Ensemble/CenterContainer3/NoTickContainer/No Tick").hide()
	YN = ""
	audio_info.play_error()

func loadNextPage(page) -> void:
	get_node("Page "+str(page)).hide()
	YN = ""
	var nextPage = get_node_or_null("Page "+str(page + 1))
	if nextPage:
		nextPage.show()
	else:
		level_info.load_level([1, 0])
		save_info.save_answer(false)
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		self.queue_free()

func markYes(page) -> void:
	get_node("Page "+str(page)+"/HSplitContainer/Yes Ensemble/CenterContainer3/YesTickContainer/Yes Tick").show()
	get_node("Page "+str(page)+"/HSplitContainer/No Ensemble/CenterContainer3/NoTickContainer/No Tick").hide()
	
func markNo(page) -> void:
	get_node("Page "+str(page)+"/HSplitContainer/Yes Ensemble/CenterContainer3/YesTickContainer/Yes Tick").hide()
	get_node("Page "+str(page)+"/HSplitContainer/No Ensemble/CenterContainer3/NoTickContainer/No Tick").show()
