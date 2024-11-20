extends Node3D

func _process(_delta: float) -> void:
	$MeshInstance3D/SubViewport/Camera3D.position = $MeshInstance3D/Marker3D.position
