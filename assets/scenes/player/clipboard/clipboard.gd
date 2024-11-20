extends Node3D

signal clipboard_raised
signal clipboard_lowered
signal answerConfirmed(answer:bool)


var targetUpDown = false # false: target is clipboard down, true: target is clipboard up
var isMoving = false

var isTooBig

var isWaterLevel: bool = false
var isUnderWater: bool = false

@onready var yes_tick: Label3D = $"MeshInstance3D/Assessment/Yes Box/Yes Tick"
@onready var no_tick: Label3D = $"MeshInstance3D/Assessment/No Box/No Tick"

@onready var level_1_text: Node3D = $MeshInstance3D/level1text
@onready var level_2_text: Node3D = $MeshInstance3D/level2text
@onready var level_3_text: Node3D = $MeshInstance3D/level3text

@onready var scribble_player: AudioStreamPlayer3D = $"scribble player"
@onready var animation_player: AnimationPlayer = $MeshInstance3D/AnimationPlayer

var scribblePlayer

func _ready() -> void:
	$"PolyphonicPlayer".play()
	scribblePlayer = $PolyphonicPlayer.get_stream_playback()

func _process(_delta: float) -> void:
	$"scribble player".global_position = global_position

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("clipboard"):
		targetUpDown = !targetUpDown # Toggles if target should be up or down

			
		

		if targetUpDown: # Animations for if the clipboard should be up
			if !isMoving: # if the clipboard was not moving prior (meaning was down)
				isMoving = true
				animation_player.play("Hold Up")
			elif isMoving: # if the clipboard was moving (cancelled from lowering)
				animation_player.play_backwards("Put Back")
		elif !targetUpDown: # Animations for if the clipboard should be lowered
			if !isMoving: #if the clipboard was not moving prior (meaning it was up)
				isMoving = true
				animation_player.play("Put Back")
			elif isMoving: # if the clipboard was moving (cancelled from raising)
				animation_player.play_backwards("Hold Up")


	if targetUpDown: # Only allow selections if clipboard is up
		if event.is_action_pressed("mark_too_big"):
			isTooBig = "true"
			if isWaterLevel:
				if isUnderWater:
					scribblePlayer.play_stream($"scribble muffle player".stream)
				else:
					scribblePlayer.play_stream($"scribble reverb player".stream)
			else:
				scribblePlayer.play_stream($"scribble player".stream)
				
		elif event.is_action_pressed("mark_not_too_big"):
			isTooBig = "false"
			if isWaterLevel:
				if isUnderWater:
					scribblePlayer.play_stream($"scribble muffle player".stream)
				else:
					scribblePlayer.play_stream($"scribble reverb player".stream)
			else:
				scribblePlayer.play_stream($"scribble player".stream)
			
			
		if isTooBig == "true":
			yes_tick.show()
			no_tick.hide()
		elif isTooBig == "false":
			no_tick.show()
			yes_tick.hide()
			
	if event.is_action_pressed("select"):
		if isTooBig == "true": # only send signals if an answer is marked
			answerConfirmed.emit(true)
		elif isTooBig == "false":
			answerConfirmed.emit(false)


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if  anim_name == "Hold Up":
		isMoving = false
		clipboard_raised.emit()
		
	elif anim_name == "Put Back":
		isMoving = false
		clipboard_lowered.emit()
	pass # Replace with function body.
	
func load_text(level) -> void:
	hide_all_text();
	if get_node_or_null("MeshInstance3D/level"+str(level)+"text"):
		get_node("MeshInstance3D/level"+str(level)+"text").show();
	
func hide_all_text() -> void:
	level_1_text.hide()
	level_2_text.hide()
	level_3_text.hide()
