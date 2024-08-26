extends AudioStreamPlayer3D

@onready var DoorHum = $DoorHum

func _on_finished() -> void:
	DoorHum.play()
