extends Node

#var all_levels = {
	#"day1": {
		##"day1": {
			##"doesEntityFit": null,
			##"levelPath": "res://assets/scenes/day 1/day1.tscn"	
		##},
		#"level1": {
			#"doesEntityFit": true,
			#"levelPath": "res://assets/scenes/day 1/level1.tscn" 
		#},
		#"level2": {
			#"doesEntityFit": false,
			#"levelPath": "res://assets/scenes/day 1/level2.tscn"
		#},
		#"level3": {
			#"doesEntityFit": false,
			#"levelPath": "res://assets/scenes/day 1/level3.tscn"
		#}
	#},
	#"day2": {
		#"level4": {
			#"doesEntityFit": false,
			#"levelPath": "res://assets/scenes/day 2/level4.tscn"
		#},
		#"level5": {
			#"doesEntityFit": true,
			#"levelPath": "res://assets/scenes/day 2/level5.tscn"
		#}
	#}
#}
var all_levels = [
	# TUTORIAL
	[
		{
			"levelPath":"res://assets/scenes/UI/tutorial.tscn",
			"name": "tutorial"
		}
	],
	# DAY 1
	[
		# DAY 1 TITLE
		{
			"levelPath": "res://assets/scenes/day 1/day1.tscn",
			"name": "day1"
		},
		{
			# LEVEL 1
			"doesEntityFit": true,
			"levelPath": "res://assets/scenes/day 1/level1.tscn" ,
			"dayNum": 1,
			"levelNum": 1
		},
		{
			# LEVEL 2
			"doesEntityFit": false,
			"levelPath": "res://assets/scenes/day 1/level2.tscn",
			"dayNum": 1,
			"levelNum": 2
		},
		{
			#  LEVEL 3
			"doesEntityFit": false,
			"levelPath": "res://assets/scenes/day 1/level3.tscn",
			"dayNum": 1,
			"levelNum": 3
		}
	],
	# DAY 2
	[
		# DAY 2 TITLE
		{
			"levelPath": "res://assets/scenes/day 2/day2.tscn",
			"name": "day2"
		},
		{
			# LEVEL 4
			"doesEntityFit": null,
			"levelPath": "res://assets/scenes/day 2/level4.tscn",
			"dayNum": 2,
			"levelNum": 4
		},
		{
			# LEVEL 5
			"doesEntityFit": null,
			"levelPath": "res://assets/scenes/day 2/level5.tscn",
			"dayNum": 2,
			"levelNum": 5 
		},
		{
			# LEVEL 6
			"doesEntityFit": null,
			"levelPath": "res://assets/scenes/day 2/level6.tscn",
			"dayNum": 2,
			"levelNum": 6 
		}
	],
		[
		# DAY 3
		{
			# LEVEL 7
			"doesEntityFit": null,
			"levelPath": "res://assets/scenes/day 3/level7.tscn",
			"dayNum": 3,
			"levelNum": 7 
		},
		{
			# LEVEL 8
			"doesEntityFit": null,
			"levelPath": "res://assets/scenes/day 3/level8.tscn",
			"dayNum": 3,
			"levelNum": 8 
		},
		{
			# LEVEL 9
			"doesEntityFit": null,
			"levelPath": "res://assets/scenes/day 3/level9.tscn",
			"dayNum": 3,
			"levelNum": 9 
		}
	]
]

# Takes an Array of two numbers representing the index of the day and level in the above all_levels
func load_level(dayLevelArray):
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	print("DEBUG [load_level]: load_level received array: "+ str(dayLevelArray)) if globals.DEBUG_VERBOSE else print()
	var dayNum = dayLevelArray[0]
	var levelNum = dayLevelArray[1]
	
	# Load Tutorial or Day Screen
	if dayLevelArray[0] == 0 || dayLevelArray[1] == 0:
		var level = load(all_levels[dayNum][levelNum].levelPath).instantiate()

		level.set_name(all_levels[dayNum][levelNum].name)
		get_tree().root.get_node("Main").add_child(level)
		get_tree().root.get_node("Main").move_child(level, 0)
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		if get_tree().root.get_node_or_null("Main/Main Menu"):
			get_tree().root.get_node("Main/Main Menu").queue_free()
		# Delete previous level
		if get_tree().root.get_node("Main").get_child(-1).name.match("level?"):
			get_tree().root.get_node("Main").get_child(-1).queue_free()
			get_tree().root.get_node("Main/player").queue_free()
		get_tree().root.get_node("Main/Pause screen").set_process_mode(Node.PROCESS_MODE_ALWAYS)
		#get_tree().root.get_node("Main/"+all_levels[dayNum][levelNum].name).confirmPressed.connect(get_tree().root.get_node("Main")._on_confirm_pressed)
		#get_tree().root.get_node("Main/"+all_levels[dayNum][levelNum].name).clickPressed.connect(get_tree().root.get_node("Main")._on_click_pressed)
		#get_tree().root.get_node("Main/"+all_levels[dayNum][levelNum].name).errorPressed.connect(get_tree().root.get_node("Main")._on_error_pressed)
	
	else:

		get_tree().paused = true
		print("DEBUG [load_level]: Loading Level number "+str(all_levels[dayNum][levelNum].levelNum)+ " from path: "+all_levels[dayNum][levelNum].levelPath) if globals.DEBUG_VERBOSE else print()
		var newLevel = "level" + str(all_levels[dayNum][levelNum].levelNum)
		var oldLevel = "level" + str(all_levels[dayNum][levelNum].levelNum - 1)
		var level = load(all_levels[dayNum][levelNum].levelPath).instantiate()
		level.set_name(newLevel)
		if get_tree().root.get_node_or_null("Main/"+oldLevel):
			get_tree().root.get_node("Main/"+oldLevel).queue_free()
		get_tree().root.get_node("Main").add_child(level)

		#get_tree().root.get_node("Main/"+newLevel).confirmPressed.connect(get_tree().root.get_node("Main")._on_confirm_pressed)
		#get_tree().root.get_node("Main/"+newLevel).clickPressed.connect(get_tree().root.get_node("Main")._on_click_pressed)
		get_tree().paused = false
		if get_tree().root.get_node_or_null("Main/Main Menu"):
			get_tree().root.get_node("Main/Main Menu").queue_free()
		get_tree().root.get_node("Main/Pause screen").set_process_mode(Node.PROCESS_MODE_ALWAYS)
		save_info.currentDay = all_levels[dayNum][levelNum].dayNum
		save_info.currentLevel = all_levels[dayNum][levelNum].levelNum
		
	
func load_next_level():
	load_level(save_info.get_next_level())
