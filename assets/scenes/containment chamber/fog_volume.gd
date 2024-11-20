extends FogVolume

@export var visible_height_offset := 0.88

func _process(_delta):
	var camera = get_viewport().get_camera_3d()
	if camera:
		visible = camera.global_position.y < ($"../Water".global_position.y + visible_height_offset)
		$"../ground (no collision)".visible = !(camera.global_position.y < ($"../Water".global_position.y + visible_height_offset))
		$"../Enclosure".visible = !(camera.global_position.y < ($"../Water".global_position.y + visible_height_offset))
		$"..".isUnderWater.emit(camera.global_position.y < ($"../Water".global_position.y + visible_height_offset))
