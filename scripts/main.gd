extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$"Pause screen".set_process_mode(4)
	$"Pause screen/Ambiance".set_process_mode(4)
	pass
	#Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

var isPaused: bool = false


func _unhandled_input(event) -> void:
	if event.is_action_pressed("ui_cancel"):
		isPaused = !isPaused
		print(isPaused)
		if isPaused:
			print("pausing")
			get_tree().paused = true
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			$"Pause screen".show()
			isPaused = true
			$"Pause screen/Ambiance".play()
			$"Pause screen/Confirm Player".play()
			print("paused")
			pass
		elif !isPaused:
			print("unpausing")
			get_tree().paused = false
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			$"Pause screen".hide()
			isPaused = false
			$"Pause screen/Ambiance".stop()
			$"Pause screen/Confirm Player".play()
			print("unpaused")

			pass


func _on_main_menu_new_game_pressed() -> void:
	var tutorial = load("res://scenes/tutorial.tscn").instantiate()
	tutorial.set_name("tutorial")
	add_child(tutorial)
	move_child(tutorial, 0)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	$"main menu".queue_free()
	$"Pause screen".set_process_mode(3)
	$"Pause screen/Ambiance".set_process_mode(3)
	$"tutorial".load_level1.connect(_on_load_level1)

func _on_load_level1() -> void:
	var level1 = load("res://scenes/level1.tscn").instantiate()
	level1.set_name("level1")
	add_child(level1)
	spawnPlayer()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	$"tutorial".queue_free()
	#$AudioStreamPlayer2D.queue_free()
	

#func _on_paused() -> void:
	#get_tree().paused = true
	#Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	#$"Pause Screen".show()
	#isPaused = true
	#$Ambiance.play()
	#pass
#
#func _on_unpaused() -> void:
	#get_tree().paused = false
	#Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	#$"Pause Screen".hide()
	#isPaused = false
	#$Ambiance.stop()
	#pass

#
#func _on_audio_stream_player_2d_finished() -> void:
	#$AudioStreamPlayer2D.play()
	
	
func _on_player_answer_confirmed(answer: bool) -> void:
	
	# TODO add state and keep track of correct/incorrect guesses
	if get_node_or_null("./level1"):
		loadLevel(2)
	elif get_node_or_null("./level2"):
		loadLevel(3)
	elif get_node_or_null("./level3"):
		pass

	pass # Replace with function body.


	
func loadLevel(levelNum) -> void:
	get_tree().paused = true
	var newLevel = "level" + str(levelNum)
	var oldLevel = "level" + str(levelNum - 1)
	var level = load("res://scenes/"+newLevel+".tscn").instantiate()
	level.set_name(newLevel)
	get_node(oldLevel).queue_free()
	add_child(level)
	resetPlayer()
	get_tree().paused = false
	
func resetPlayer() -> void:
	# TODO pass down variable to tell the clipboard what data to show?
	get_tree().paused = true
	$player.set_name("oldPlayer")
	$oldPlayer.queue_free()
	spawnPlayer()
	get_tree().paused = false
	
func spawnPlayer() -> void:
	await get_tree().create_timer(1).timeout
	var player = load("res://scenes/player.tscn").instantiate()
	player.set_name("player")
	add_child(player)
	move_child(player, 1)
	$player.clipboard_answer_confirmed_player.connect(_on_player_answer_confirmed)
	
func showOptions() -> void:
	$"Pause screen".set_process_mode(3)

	$"Pause screen".show()
	$"Pause screen/Pause Screen Margin/Options Menu".show()
	$"Pause screen/Pause Screen Margin/Pause Screen".hide()
	if get_node_or_null("main menu"):
		$"main menu".hide()

func hideOptions() -> void:
	$"Pause screen".set_process_mode(4)
	$"Pause screen/Pause Screen Margin/Options Menu".hide()
	$"Pause screen/Pause Screen Margin/Pause Screen".show()
	if get_node_or_null("main menu"):
		$"Pause screen".hide()
		$"main menu".show()



func _on_main_menu_options_pressed() -> void:
	showOptions();
	pass # Replace with function body.


func _on_pause_screen_show_options() -> void:
	showOptions();
	pass # Replace with function body.


func _on_pause_screen_hide_options() -> void:
	hideOptions()
	pass # Replace with function body.
