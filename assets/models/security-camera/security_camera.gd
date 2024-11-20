extends Node3D

## Node that the camera will point towards.
@export var targetNode: CharacterBody3D 

@onready var trackingCam: Camera3D = $trackingCam

func _process(_delta: float) -> void:
	if targetNode == null:
		if get_tree().root.get_node_or_null("Main/player"):
			targetNode = get_tree().root.get_node("Main/player")
	else:
		trackingCam.look_at(targetNode.get_global_position())
	

	
