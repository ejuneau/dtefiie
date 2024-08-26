extends Control

signal exitOptions

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Check if an options file exists, if not makes one
	# Creates temporary new options file
	# if any value is chagned, log values in temp file, hide Back button and show Save/Discard 
	# on confirmation, commit temp file values to options file
	# on discard, delete contents of temp file
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if $Back.is_visible_in_tree() :
		$Save.hide()
		$Discard.hide()
	elif !$Back.is_visible_in_tree() :
		$Save.show()
		$Discard.show()
		
	# if valueChanged: $Back.hide()
	
	pass



func _on_back_pressed() -> void:
	exitOptions.emit()
	hide()
	pass # Replace with function body.
