extends CharacterBody3D

@export_category("Movement Variables")
@export var SPEED = 5.0
@export var JUMP_VELOCITY = 4.5

@export_category("Node References")
@export var CameraNode: Node3D
@export var CameraActual: Node3D
@export var ClipboardNode: Node3D

@export_category("Animations")
@export var animationTree: AnimationTree

@export_group("Animation Names")
@export var HandStateMachinePlaybackPath: String
@export var IdleAnimationName: String

@export_category("Camera Shake Variablels")
@export var CameraShake_Noise : Noise
@export var CameraShake_NoisePanningSpeed : float = 30
@export var CameraShake_MaxPower: float = 0.15
@export var CameraShake_BlendSpeed: float = 7
@export var CameraShake_ReturnStrength: float = 5
@export var CameraShake_NoiseStrength: float = 0.2

@export var CameraShakePower: float = 0.3

@export var CameraShake_FallingBias: float = 1.0
@export var CameraShake_FallingStrengthFalloff: float = 2.0
@export var CameraShake_FallingMaxStrength: float = 1.0
@export var CameraShake_JumpingStrength: float = 0.2

@export_category("Walking Sway Variables")
@export var WalkingSway_StepsPerSecond: float = 5.0
@export var WalkingSway_MaxSwayDistance : float = 0.05
@export var WalkingSway_MaxSwayCameraHeight: float = 0.01
@export var WalkingSway_MaxSwayHandsHeight: float = -0.005
@export var WalkingSway_BlendSpeed: float = 5
@export var WalkingSway_Bias: float = 0.5

@export_category("Rotation Variables")
@export var VerticalRecoil: float = 2
@export var RotationSpeed: float = 0.3
@export var CameraActualRotationSpeed: float = 20
@export var ArmsActualRotationSpeed: float = 12
@export var VerticalRotationLimit: float = 80


@onready var neck := $Neck
@onready var camera := $Neck/Camera3D
@onready var model: Node3D = $model


var targetRotation: Vector3;
var clipboard_up : bool = false

var ArmsBasePosition : Vector3
var walkingSway_CurrentValue: float

var cameraShake_Position:Vector3
var timeSinceStarted: float

var lastYVelocity : float

var HandOffsetPosition: Vector3;

var landing : bool

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	ArmsBasePosition = ClipboardNode.position

func _unhandled_input(event) -> void:
	
	# If game is focused, control camera
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			neck.rotate_y(-event.relative.x * 0.01)
			camera.rotate_x(-event.relative.y * 0.01)
			rotate_model(event.relative.x, clamp(camera.rotation.x, deg_to_rad(-80), deg_to_rad(60)), camera.rotation.x)
			camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-80), deg_to_rad(60))

func _physics_process(delta: float) -> void:
	#Beginning of Camera shake code
	timeSinceStarted += delta * CameraShake_NoisePanningSpeed
	if (cameraShake_Position.length() > 0.0001):
		var noise : Vector3 = (Vector3(CameraShake_Noise.get_noise_1d(timeSinceStarted), CameraShake_Noise.get_noise_1d(timeSinceStarted + 1000), CameraShake_Noise.get_noise_1d(timeSinceStarted + 2000)) * CameraShake_NoiseStrength) * (cameraShake_Position.length() / CameraShake_MaxPower)
		CameraActual.position = CameraActual.position.lerp(
			cameraShake_Position + noise, 
			delta * CameraShake_BlendSpeed);
			
		cameraShake_Position = cameraShake_Position.lerp(Vector3.ZERO, delta * CameraShake_ReturnStrength)
	else:
		CameraActual.position = Vector3.ZERO
		
	#End of Camera shake code
	
	$"Neck/Camera3D/Clipboard Container/Clipboard".global_position += HandOffsetPosition * 0.1
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	#Camera shake code begin
		walkingSway_CurrentValue = max(walkingSway_CurrentValue - delta * WalkingSway_BlendSpeed, 0) 
		lastYVelocity = velocity.y
	else:
		if (lastYVelocity < -CameraShake_FallingBias):
			ImpulseCamera(Vector3.DOWN, smoothstep(CameraShake_FallingBias, CameraShake_FallingStrengthFalloff + CameraShake_FallingBias, abs(lastYVelocity)) * CameraShake_FallingMaxStrength)
			
		if (velocity.length() > WalkingSway_Bias):
			walkingSway_CurrentValue = min(walkingSway_CurrentValue + delta * WalkingSway_BlendSpeed, 1.0)
		else:
			walkingSway_CurrentValue = max(walkingSway_CurrentValue - delta * WalkingSway_BlendSpeed, 0)
			
	lastYVelocity = velocity.y
	if walkingSway_CurrentValue > 0:
		var stepSpeed: float = delta * WalkingSway_StepsPerSecond
		var stepBounce: float = (EaseInOutSine(-1.0, 1.0, timeSinceStarted * stepSpeed * 2.0 + 0.2) * -1.0 * WalkingSway_MaxSwayHandsHeight)

			
			
		cameraShake_Position.y += (EaseInOutSine(-1.0, 1.0, timeSinceStarted * stepSpeed * 2.0 + 0.2 ) * -1.0 * WalkingSway_MaxSwayCameraHeight * (0.2 if clipboard_up else 1.0))
		
		HandOffsetPosition = CameraNode.transform.basis * (Vector3(
			EaseInOutSine(-1.0, 1.0, timeSinceStarted * stepSpeed * 2.0 + 0.2) * WalkingSway_MaxSwayDistance,
			stepBounce,
			0.0) * walkingSway_CurrentValue * (0.2 if clipboard_up else 1.0));
	else:
		HandOffsetPosition = Vector3.ZERO
	#Camera shake code end



	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	# Play sound when landing jump


	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (neck.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = -direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	
func ImpulseCamera(impulseVector: Vector3, impulsePower: float):
	cameraShake_Position += impulseVector * impulsePower
	cameraShake_Position = cameraShake_Position.normalized() * min(cameraShake_Position.length(), CameraShake_MaxPower)
	
func ImpulseCameraWithRecoil(impulseVector: Vector3, impulsePower: float):
	targetRotation.x += VerticalRecoil
	ImpulseCamera(impulseVector, impulsePower)

func EaseInOutSine(start: float, end: float, value: float) -> float:
	end -= start;
	return -end * 0.5 * (cos(PI * value) - 1.0) + start


func _on_clipboard_raised() -> void:
	clipboard_up = true


func _on_clipboard_lowered() -> void:
	clipboard_up = false
	

	
func rotate_model(x, y, _cameraRot) -> void:
	# TODO implement model neck rotation
	# x and y are event.relative.x/y respectively
	model.rotate_y(-x * 0.01)
	#rotate neck up/down
	# from video:
	# q = cos(angle) + sin(angle) * (normalized Vector)
	#var quaternion = Quaternion(0.1, 0, 0, -x * 10)
	var currentQuat = $model/masc.get_bone_pose_rotation($model/masc.find_bone("neck2_15"))
	var newQuat = Quaternion(1, 0, 0, -y * 0.01)
#$model/fem.set_bone_pose_rotation($model/fem.find_bone("head_14"), y)
	var finalQuat = (currentQuat * newQuat).normalized()
	$model/masc.set_bone_pose_rotation($model/masc.find_bone("neck2_15"),  finalQuat)
