extends Node

@onready var clickPlayer: AudioStreamPlayer2D = get_tree().root.get_node_or_null("Main/Audio/Click");
@onready var confirmPlayer: AudioStreamPlayer2D = get_tree().root.get_node_or_null("Main/Audio/Confirm");
@onready var errorPlayer: AudioStreamPlayer2D = get_tree().root.get_node_or_null("Main/Audio/Error");



func play_click() -> void:
	if clickPlayer != null:
		clickPlayer.play()
	else:
		print("[audio_info/play_click()] No clickPlayer!")

func play_confirm() -> void:
	if confirmPlayer != null:
		confirmPlayer.play()
	else:
		print("[audio_info/play_confirm()] No confirmPlayer!")

func play_error() -> void:
	if errorPlayer != null:
		errorPlayer.play()
	else:
		print("[audio_info/play_error()] No errorPlayer!")
