extends Node


var currentDay
var currentLevel

var saveDataFromDisk
var dataToSave
#var PLACEHOLDER_SAVE_DATA = [
	#[
		## DAY 1
		#{
			## LEVEL 1
			#"doesEntityFit": true,
		#},
		#{
			## LEVEL 2
			#"doesEntityFit": false,
		#},
	#]
#]

func _ready() -> void:
	#saveProgressToDisk(PLACEHOLDER_SAVE_DATA)
	saveDataFromDisk = get_data_from_disk()
	dataToSave = get_data_from_disk()
	if save_data_exists():
		currentDay = saveDataFromDisk[-1].dayNum
		currentLevel = saveDataFromDisk[-1].levelNum
	else:
		currentDay = 0
		currentLevel = 0
	print("DEBUG [save_info _ready]: saveDataFromDisk: "+str(saveDataFromDisk))

func delete_all_save_data() -> void:
	var dir = DirAccess.open("user://")
	dir.remove("user://save.dat")
	saveDataFromDisk = null
	dataToSave = null
	currentDay = 0
	currentLevel = 0

func save_data_to_disk(dataToSave) -> void:

	var file = FileAccess.open("user://save.dat", FileAccess.WRITE)
	file.store_string(JSON.stringify(dataToSave, "\t"))
	file.close()
	saveDataFromDisk = get_data_from_disk()
	
func get_data_from_disk():
	if save_data_exists():
		return JSON.parse_string(FileAccess.open("user://save.dat", FileAccess.READ).get_as_text())
	else:
		print("DEBUG [get_data_from_disk] - No save data exists!") if globals.DEBUG_VERBOSE else print()
		return null
		
func save_data_exists() -> bool:
	return true if FileAccess.file_exists("user://save.dat") else false
	
# Returns array of most recent day and most recent level
#func level_to_load() -> Array:
	#saveDataFromDisk = get_data_from_disk()
	#if saveDataFromDisk == null:
		#return [0, "tutorial"]
	#else:
		##print("DEBUG: LevelToLoad returning ["+str(saveDataFromDisk.size())+", "+str(saveDataFromDisk[saveDataFromDisk.size() - 1 ].size() + 1)+"]") if globals.DEBUG_VERBOSE else print()
		##var lastDay = saveDataFromDisk.size()
		##var lastLevel = saveDataFromDisk[lastDay - 1 ].size() + 1
		##print("DEBUG: Last Day: "+str(lastDay)+" | Last Level: "+str(lastLevel)) if globals.DEBUG_VERBOSE else print()
		##return [lastDay, lastLevel]
		#var lastDay = saveDataFromDisk[-1].dayNum
		#var lastLevel = saveDataFromDisk[-1].levelNum
		#print("DEBUG: level_to_load returning ["+str(lastDay)+", "+str(lastLevel)+"]")
		#currentDay = lastDay
		#currentLevel = lastLevel
		#return [lastDay, lastLevel]
		
func get_next_level() -> Array: 
	# Read current day/level, and return the next level in the same day
	# OR, if there are no more levels in that day, return the day screen 
	# of the next day
	print("DEBUG [get_next_level] - currentDay: "+str(currentDay)+" currentLevel: "+str(currentLevel))
	if level_info.all_levels[currentDay].size() > currentLevel + 1:
		return [currentDay, currentLevel+1]
	else:
		
		return [currentDay+1, 0]
		
func save_answer(answer: bool) -> void:
	print("DEBUG [save_answer]: answer: " + str(answer))
	#var currentDayLevelArray = level_to_load()
	if save_data_exists():
			dataToSave.append(
				{
					"doesEntityFit": answer,
					"dayNum": currentDay,
					"levelNum": currentLevel
				}
			)
	else:
		dataToSave = [
				{
					"doesEntityFit": answer,
					"dayNum": 0,
					"levelNum": 1
				}
		]
	save_data_to_disk(dataToSave)
	saveDataFromDisk = get_data_from_disk()
	
