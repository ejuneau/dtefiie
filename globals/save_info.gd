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
	saveDataFromDisk = getProgressFromDisk()
	dataToSave = getProgressFromDisk()
	print("DEBUG: saveDataFromDisk: "+str(saveDataFromDisk))

func deleteAllSaveData() -> void:
	var dir = DirAccess.open("user://")
	dir.remove("user://save.dat")
	saveDataFromDisk = null
	dataToSave = null
	currentDay = 0
	currentLevel = 0

func saveProgressToDisk(dataToSave) -> void:

	var file = FileAccess.open("user://save.dat", FileAccess.WRITE)
	file.store_string(JSON.stringify(dataToSave, "\t"))
	file.close()
	saveDataFromDisk = getProgressFromDisk()
	
func getProgressFromDisk():
	if FileAccess.file_exists("user://save.dat"):
		#print(JSON.parse_string(FileAccess.open("user://save.dat", FileAccess.READ).get_as_text())) if globals.DEBUG_VERBOSE else print()
		return JSON.parse_string(FileAccess.open("user://save.dat", FileAccess.READ).get_as_text())
	else:
		#print("No save data exists!") if globals.DEBUG_VERBOSE else print()
		return null
		
func saveDataExists() -> bool:
	return true if FileAccess.file_exists("user://save.dat") else false
	
# Returns array of most recent day and most recent level
func levelToLoad() -> Array:
	saveDataFromDisk = getProgressFromDisk()
	if saveDataFromDisk == null:
		return [0, "tutorial"]
	else:
		print("DEBUG: LevelToLoad returning ["+str(saveDataFromDisk.size())+", "+str(saveDataFromDisk[saveDataFromDisk.size() - 1 ].size() + 1)+"]") if globals.DEBUG_VERBOSE else print()
		var lastDay = saveDataFromDisk.size()
		var lastLevel = saveDataFromDisk[lastDay - 1 ].size() + 1
		print("Last Day: "+str(lastDay)+" | Last Level: "+str(lastLevel)) if globals.DEBUG_VERBOSE else print()
		return [lastDay, lastLevel]
		
func getNextLevel() -> Array: 
	# Read current day/level, and return the next level in the same day
	# OR, if there are no more levels in that day, return the day screen 
	# of the next day
	if level_info.all_levels[currentDay].size() > currentLevel + 1:
		return [currentDay, currentLevel+1]
	else:
		
		return [currentDay+1, 0]
		
func recordNewProgress(answer: bool) -> void:
	print("DEBUG: Recording Answer: " + str(answer))
	var currentDayLevelArray = levelToLoad()
	if saveDataExists():
		if dataToSave.size() == currentDayLevelArray[0]:
			dataToSave[currentDayLevelArray[0]].append({"doesEntityFit": answer})
		else:
			dataToSave.append({"doesEntityFit": answer})
	else:
		dataToSave = [
			[
				{
					"doesEntityFit": answer
				}
			]
		]
	saveProgressToDisk(dataToSave)
	saveDataFromDisk = getProgressFromDisk()
	
