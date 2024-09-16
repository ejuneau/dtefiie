extends MenuButton

signal errorPressed

var popup

func _ready():
	popup = get_popup()
	var theme = load("res://assets/themes/theme2.tres")
	popup.set_theme(theme)
	popup.connect("id_pressed", _on_item_pressed)

func _on_item_pressed(_ID):
	save_info.delete_all_save_data()
	errorPressed.emit()



func _process(_delta):
	if FileAccess.file_exists("user://save.dat"):
		show()
	else:
		hide()
