extends Node



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	#Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


		

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass

func _on_new_game_pressed() -> void:
	#var level1 = load("res://level1.tscn")
	#var level1_instance = level1.instantiate()
	#level1_instance.set_name("level1")
	#add_child(level1_instance)
	#Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	#hide()
	var tutorial = load("res://tutorial.tscn")
	var tutorial_instance = tutorial.instantiate()
	tutorial_instance.set_name("tutorial")
	get_tree().add_child(tutorial)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	$"main menu".hide()
	pass # Replace with function body.
	
func start_new_game() -> void:
	var level1 = load("res://level1.tscn")
	var level1_instance = level1.instantiate()
	level1_instance.set_name("level1")
	add_child(level1_instance)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	$tutorial.hide()


func _on_main_menu_new_game_pressed() -> void:
		#var level1 = load("res://level1.tscn")
	#var level1_instance = level1.instantiate()
	#level1_instance.set_name("level1")
	#add_child(level1_instance)
	#Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	#hide()
	var tutorial = load("res://tutorial.tscn")
	var tutorial_instance = tutorial.instantiate()
	tutorial_instance.set_name("tutorial")
	add_child(tutorial_instance)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	$"main menu".queue_free()

func _on_tutorial_load_level_1() -> void:
	var level1 = load("res://level1.tscn")
	var level1_instance = level1.instantiate()
	level1_instance.set_name("level1")
	add_child(level1_instance)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	$"Tutorial".queue_free()
