extends Node



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$"Pause screen".set_process_mode(4)
	$"Pause screen/Ambiance".set_process_mode(4)
	pass
	#Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

var isPaused: bool = false






# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass

#func _on_new_game_pressed() -> void:
	##var level1 = load("res://level1.tscn")
	##var level1_instance = level1.instantiate()
	##level1_instance.set_name("level1")
	##add_child(level1_instance)
	##Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	##hide()
	#var tutorial = load("res://tutorial.tscn")
	#var tutorial_instance = tutorial.instantiate()
	#tutorial_instance.set_name("tutorial")
	#get_tree().add_child(tutorial)
	#Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	#print("enabling pause screen")
	#$"Pause screen".set_process_mode(3)
	#$"main menu".hide()
	#pass # Replace with function body.
	
#func start_new_game() -> void:
	#var level1 = load("res://level1.tscn")
	#var level1_instance = level1.instantiate()
	#level1_instance.set_name("level1")
	#add_child(level1_instance)
	#Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	#$tutorial.hide()


func _on_main_menu_new_game_pressed() -> void:
		#var level1 = load("res://level1.tscn")
	#var level1_instance = level1.instantiate()
	#level1_instance.set_name("level1")
	#add_child(level1_instance)
	#Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	#hide()
	var tutorial = load("res://scenes/tutorial.tscn").instantiate()
	tutorial.set_name("tutorial")
	add_child(tutorial)
	move_child(tutorial, 0)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	$"main menu".queue_free()
	$"Pause screen".set_process_mode(3)
	$"tutorial".load_level1.connect(_on_load_level1)

func _on_load_level1() -> void:
	var level1 = load("res://scenes/level1.tscn").instantiate()
	level1.set_name("level1")
	add_child(level1)
	spawnPlayer()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	$"tutorial".queue_free()
	#$AudioStreamPlayer2D.queue_free()
	

func _on_paused() -> void:
	get_tree().paused = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	$"Pause Screen".show()
	isPaused = true
	$Ambiance.play()
	pass

func _on_unpaused() -> void:
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	$"Pause Screen".hide()
	isPaused = false
	$Ambiance.stop()
	pass


func _on_audio_stream_player_2d_finished() -> void:
	$AudioStreamPlayer2D.play()
	
	
func _on_player_answer_confirmed(answer: bool) -> void:
	
	# TODO add state and keep track of correct/incorrect guesses
	if get_node_or_null("./level1"):
		loadLevel(2)
	elif get_node_or_null("./level2"):
		loadLevel(3)
	elif get_node_or_null("./level3"):
		pass

	pass # Replace with function body.

#func loadLevel2() -> void:
	#get_tree().paused = true
	#var level2 = load("res://level2.tscn").instantiate()
	#level2.set_name("level2")
	#$level1.queue_free()
	#add_child(level2)
	#resetPlayer()
	#get_tree().paused = false

#func loadLevel3() -> void:
	#get_tree().paused = true
	#var level3 = load("res://level3.tscn").instantiate()
	#level3.set_name("level3")
	#$level2.queue_free()
	#add_child(level3)
	#resetPlayer()
	#get_tree().paused = false
	
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
