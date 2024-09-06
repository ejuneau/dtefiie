extends Node3D

@onready var masc: Skeleton3D = $masc
@onready var fem: Skeleton3D = $fem

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func toggle_model() -> void:
	if fem.is_visible_in_tree():
		fem.hide()
		masc.show()
	elif masc.is_visible_in_tree():
		masc.hide()
		fem.show()
