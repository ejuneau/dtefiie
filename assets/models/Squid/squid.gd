extends Node3D

func _process(_delta: float) -> void:
	look_at(get_viewport().get_camera_3d().global_transform.origin, Vector3.UP, true)
