extends Node

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


func _on_player_initialize_sprites():
	body.texture  = GlobalPlayerManager.player_skins_collection[GlobalPlayerManager.selected_player_skin]
	body.modulate = GlobalPlayerManager.selected_player_skin_color
	eyes.texture =  GlobalPlayerManager.player_eyes_collection[GlobalPlayerManager.selected_player_eye]
	eyes.modulate = GlobalPlayerManager.selected_player_eye_color
	hairs.texture = GlobalPlayerManager.player_hairs_collection[GlobalPlayerManager.selected_player_hair]
	hairs.modulate = GlobalPlayerManager.selected_player_hair_color
	clothe.texture = GlobalPlayerManager.player_clothes_collection[GlobalPlayerManager.selected_player_clothe]
	clothe.modulate = GlobalPlayerManager.selected_player_clothe_color
	hood.texture = GlobalPlayerManager.player_hoods_collection[GlobalPlayerManager.selected_player_hood]
	hood.modulate = GlobalPlayerManager.selected_player_hood_color
	tools.texture = null
	fx.texture = null
	pass # Replace with function body.