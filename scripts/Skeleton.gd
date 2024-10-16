class_name skeleton extends Node

@onready var body = $Body
@onready var eyes = $Eyes
@onready var hairs = $Hairs
@onready var hood = $Hood
@onready var clothe = $Clothe
@onready var tools = $Tools
@onready var fx = $Fx

func _on_player_change_direction_x(x : int):
	if x > 0:
		body.flip_h = false
		eyes.flip_h = false
		hairs.flip_h = false
		hood.flip_h = false
		clothe.flip_h = false
		tools.flip_h = false
		fx.flip_h = false
	else:
		body.flip_h = true
		eyes.flip_h = true
		hairs.flip_h = true
		hood.flip_h = true
		clothe.flip_h = true
		tools.flip_h = true
		fx.flip_h = true
	pass # Replace with function body.
