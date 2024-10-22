extends Node3D

@export_category("Node References")
## The camera that captures the mirror's reflection.
@onready var mirrorCam: Camera3D = $SubViewport/Camera3D

## The player node. Contains a child node `Neck` which handles x-axis rotation, which itself has child node `camera3D` to handle y-axis rotation.
@export var player: CharacterBody3D
## Node located directly in the centre of the mirror.
@onready var mirrorCenter: Node3D = $"Mirror Frame/Mirror Center"
## Nodes sharing their global_position with the respective vertices of the mirror sprite
@onready var tr: Marker3D = $"Mirror Frame/Viewport Texture/TR"
@onready var tl: Marker3D = $"Mirror Frame/Viewport Texture/TL"
@onready var bl: Marker3D = $"Mirror Frame/Viewport Texture/BL"
@onready var br: Marker3D = $"Mirror Frame/Viewport Texture/BR"


var playerCam
var mirrorCenterPosition
var playerCamPosition
var playerNeck

var screenSize = DisplayServer.window_get_size()

var TRUV: Vector2
var TLUV: Vector2
var BRUV: Vector2
var BLUV: Vector2

func _ready() -> void:
	playerNeck = player.get_child(2) # Neck node (x-axis rotation)
	playerCam = playerNeck.get_child(0) # Canera3D node (y-axis rotation)
	mirrorCenterPosition = mirrorCenter.get_global_position()
	playerCamPosition = playerCam.get_global_position()
	mirrorCenterPosition = mirrorCenter.get_global_position()
	
	
	var mirrorSize = Vector2(tr.get_position().x - tl.get_position().x, tl.get_position().y - bl.get_position().y)
	$"Mirror Frame/Viewport Texture".mesh.size = mirrorSize

func round_place(num,places):
	return (round(num*pow(10,places))/pow(10,places))
	
	
func _physics_process(_delta: float) -> void:
	TRUV = Vector2((mirrorCam.unproject_position( tr.get_global_position() ).x / screenSize.x), (mirrorCam.unproject_position( tr.get_global_position() ).y / screenSize.y))
	TLUV = Vector2((mirrorCam.unproject_position( tl.get_global_position() ).x / screenSize.x), (mirrorCam.unproject_position( tl.get_global_position() ).y / screenSize.y))
	BRUV = Vector2((mirrorCam.unproject_position( br.get_global_position() ).x / screenSize.x), (mirrorCam.unproject_position( br.get_global_position() ).y / screenSize.y))
	BLUV = Vector2((mirrorCam.unproject_position( bl.get_global_position() ).x / screenSize.x), (mirrorCam.unproject_position( bl.get_global_position() ).y / screenSize.y))

	$"Mirror Frame/Viewport Texture".material_overlay.set_shader_parameter("TR", TRUV);
	$"Mirror Frame/Viewport Texture".material_overlay.set_shader_parameter("TL", TLUV);
	$"Mirror Frame/Viewport Texture".material_overlay.set_shader_parameter("BR", BRUV);
	$"Mirror Frame/Viewport Texture".material_overlay.set_shader_parameter("BL", BLUV);

	### DEBUG INFO
	$"Mirror Frame/Viewport Texture/TR/Label".text = "("+str( round_place( TRUV.x, 2 )) + ", " + str( round_place( TRUV.y, 2 )) + ")" 
	$"Mirror Frame/Viewport Texture/TL/Label".text = "("+str( round_place( TLUV.x, 2 )) + ", " + str( round_place( TLUV.y, 2 )) + ")"
	$"Mirror Frame/Viewport Texture/BR/Label".text = "("+str( round_place( BRUV.x, 2 )) + ", " + str( round_place( BRUV.y, 2 )) + ")" 
	$"Mirror Frame/Viewport Texture/BL/Label".text = "("+str( round_place( BLUV.x, 2 )) + ", " + str( round_place( BLUV.y, 2 )) + ")" 

	
	#$"../CanvasLayer/RichTextLabel".text = str(Engine.get_frames_per_second())
	
	# Update position of playerCam
	playerCamPosition = playerCam.get_global_position()
	
	# Get distance from playerCam to mirror center
	var playerDistanceToMirror = Vector3(
		playerCamPosition.x - mirrorCenterPosition.x, 
		playerCamPosition.y - mirrorCenterPosition.y, 
		playerCamPosition.z - mirrorCenterPosition.z)
		
	# Set mirrorCam distance to opposite distance from mirror center
	mirrorCam.set_global_position(Vector3(
		mirrorCenterPosition.x - playerDistanceToMirror.x, 
		mirrorCenterPosition.y + playerDistanceToMirror.y,
		mirrorCenterPosition.z + playerDistanceToMirror.z))
	
	# Set camera rotation to opposite of player's
	mirrorCam.rotation_degrees = Vector3(
		playerCam.get_rotation_degrees().x,
		180-playerNeck.get_rotation_degrees().y,
		playerNeck.get_rotation_degrees().z)
	# TODO Crop SubViewPort to only show what is contained within vertices of mirror
	pass
