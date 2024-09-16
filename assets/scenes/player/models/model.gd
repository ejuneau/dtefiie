extends Node3D

@onready var masc: Skeleton3D = $masc
@onready var fem: Skeleton3D = $fem

func toggle_model() -> void:
	if fem.is_visible_in_tree():
		fem.hide()
		masc.show()
	elif masc.is_visible_in_tree():
		masc.hide()
		fem.show()
