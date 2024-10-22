extends Node

var global_config

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$"Pause screen".set_process_mode(Node.PROCESS_MODE_DISABLED)
	#$"Pause screen/Ambiance".set_process_mode(4)
	# establish global config

	
	# DEBUG PURPOSES DELETE THIS DELETE THIS
	#global_config = config_info.getConfigFromDisk()
	#config_info.effectuate_options(global_config)


	pass
	#Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

var isPaused: bool = false

#func _process(delta) -> void:
	#pass

func _unhandled_input(event) -> void:
	if event.is_action_pressed("ui_cancel"):
		if !$"Pause screen".get_process_mode() == 4:
			isPaused = !isPaused
			if isPaused:
				pauseGame()
			elif !isPaused:
				unpauseGame()



func _on_main_menu_new_game_pressed() -> void:
	level_info.load_level([0, 0])
	$"Pause screen/Pause Screen Margin/Options Menu/VSplit/TabContainer/General/MarginContainer/VBoxContainer/Delete All Save Data".disabled = true

#func _on_load_level1() -> void:
	#var level1 = load("res://assets/scenes/day 1/level1.tscn").instantiate()
	#level1.set_name("level1")
	##spawnPlayer()
	#add_child(level1)
	#Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	#$Audio/Ambiance.stop()
	#$day1.queue_free()
	#$"level1".confirmPressed.connect(_on_confirm_pressed)
	##$"level1".clickPressed.connect(_on_click_pressed)
#
	#await get_tree().create_timer(1).timeout
	#var clipboard = get_node("player/Neck/Camera3D/Clipboard Container/Clipboard")
	#clipboard.load_text(1)
	##$AudioStreamPlayer2D.queue_free()
	
	
func _on_answer_confirmed(answer: bool) -> void:
	#print("CONFIRMED") if globals.DEBUG_VERBOSE else print()
	# TODO add state and keep track of correct/incorrect guesses
	# CHOICES.append(day, level, answer)
	save_info.save_answer(answer)
	level_info.load_next_level()
	#if get_tree().root.get_node_or_null("Main/level1"):
		## Trying loading from all_levels
		#level_info.load_level([0, 1])
		#
		#
		#
	#elif get_tree().root.get_node_or_null("Main/level2"):
		#level_info.load_level([0,2])
	#elif get_tree().root.get_node_or_null("Main/level3"):
		#level_info.load_level([0,3])

	pass # Replace with function body.


	
#func loadLevel(levelNum) -> void:
	## TODO Incorporate DaySystem here
	#get_tree().paused = true
	#var newLevel = "level" + str(levelNum)
	#var oldLevel = "level" + str(levelNum - 1)
	#var level = load("res://assets/scenes/day 1/"+newLevel+".tscn").instantiate()
	#level.set_name(newLevel)
	#get_node(oldLevel).queue_free()
	#add_child(level)
	#resetPlayer()
	#get_node(newLevel).confirmPressed.connect(_on_confirm_pressed)
	#get_node(newLevel).clickPressed.connect(_on_click_pressed)
	#await get_tree().create_timer(1).timeout
	#var clipboard = get_node("player/Neck/Camera3D/Clipboard Container/Clipboard")
	#clipboard.load_text(levelNum)
	#get_tree().paused = false
	
func resetPlayer() -> void:
	# TODO pass down variable to tell the clipboard what data to show?
	get_tree().paused = true
	get_tree().root.get_node("Main/player").set_name("oldPlayer")
	get_tree().root.get_node("Main/oldPlayer").queue_free()
	spawnPlayer()
	get_tree().paused = false
	
func spawnPlayer() -> void:
	await get_tree().create_timer(1).timeout
	var player = load("res://assets/scenes/player/player.tscn").instantiate()
	player.set_name("player")
	add_child(player)
	player.answerConfirmed.connect(_on_answer_confirmed)
	move_child(player, 1)
	
func showOptions() -> void:
	$"Pause screen".set_process_mode(Node.PROCESS_MODE_ALWAYS)
	$"Pause screen".show()
	$"Pause screen/Pause Screen Margin/Options Menu".show()
	$"Pause screen/Pause Screen Margin/Pause Screen".hide()
	if get_node_or_null("Main Menu"):
		$"Main Menu".hide()

func hideOptions() -> void:
	$"Pause screen/Pause Screen Margin/Options Menu".hide()
	$"Pause screen/Pause Screen Margin/Pause Screen".show()
	if get_node_or_null("Main Menu"):
		$"Pause screen".set_process_mode(Node.PROCESS_MODE_DISABLED)
		$"Pause screen".hide()
		$"Main Menu".show()



func _on_main_menu_options_pressed() -> void:
	showOptions();
	pass # Replace with function body.


func _on_pause_screen_show_options() -> void:
	showOptions();
	pass # Replace with function body.


func _on_pause_screen_hide_options() -> void:
	hideOptions()
	pass # Replace with function body.


func _on_pause_screen_unpaused() -> void:
	unpauseGame()
	pass # Replace with function body.
	
func pauseGame() -> void:
	get_tree().paused = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	$"Pause screen".show()
	isPaused = true
	if !get_node_or_null("tutorial"):
		$"Audio/Ambiance".play()
	$"Audio/Confirm".play()

func unpauseGame() -> void:
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	hideOptions()
	$"Pause screen".hide()
	isPaused = false
	if !get_node_or_null("tutorial"):
		$"Audio/Ambiance".stop()
	$"Audio/Confirm".play()

func fetch_new_global_config() -> void:
	global_config = $"Pause screen/Pause Screen Margin/Options Menu".getConfigFromOptions()
	


func _on_pause_screen_options_saved() -> void:
	fetch_new_global_config()
	config_info.effectuate_options(global_config)
	
func _on_new_settings() -> void:
	fetch_new_global_config()
	config_info.effectuate_options(global_config)


	


func _on_ambiance_finished() -> void:
	$Audio/Ambiance.play()
	pass # Replace with function body.



#func _on_click_pressed() -> void:
	#audio_info.play_click()
	#pass # Replace with function body.
#
#
#func _on_error_pressed() -> void:
	#audio_info.play_error()
	#pass # Replace with function body.
#
#func _on_confirm_pressed() -> void:
	#audio_info.play_confirm()

#func _on_load_day_1() -> void:
	#var day1 = load("res://assets/scenes/day 1/day1.tscn").instantiate()
	#day1.set_name("day1")
	#add_child(day1)
	#$tutorial.queue_free()
	#$"day1".confirmPressed.connect(_on_confirm_pressed)
	#$"day1".clickPressed.connect(_on_click_pressed)
	##$"day1".loadLevel1.connect(_on_load_level1)
