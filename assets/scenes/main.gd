extends Node

var global_config

func _ready() -> void:
	$"Pause screen".set_process_mode(Node.PROCESS_MODE_DISABLED)
	
var isPaused: bool = false

func _unhandled_input(event) -> void:
	if event.is_action_pressed("ui_cancel"):
		if !$"Pause screen".get_process_mode() == 4:
			isPaused = !isPaused
			if isPaused:
				pauseGame()
			elif !isPaused:
				unpauseGame()

func _on_main_menu_new_game_pressed() -> void:
	$Overlay.hide()
	level_info.load_level([0, 0])
	$"Pause screen/Pause Screen Margin/Options Menu/VSplit/TabContainer/General/MarginContainer/VBoxContainer/Delete All Save Data".disabled = true	
	
func _on_answer_confirmed(answer: bool) -> void:
	save_info.save_answer(answer)
	level_info.load_next_level()

	
func resetPlayer() -> void:
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
	if save_info.currentDay == 1 && save_info.currentLevel == 3:
		player.isWaterLevel = true
	else:
		player.isWaterLevel = false
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

func _on_pause_screen_show_options() -> void:
	showOptions();

func _on_pause_screen_hide_options() -> void:
	hideOptions()

func _on_pause_screen_unpaused() -> void:
	unpauseGame()
	
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


func _on_main_menu_continue_pressed() -> void:
	$Overlay.hide()
