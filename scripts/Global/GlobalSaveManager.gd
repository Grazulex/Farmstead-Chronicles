extends Node

const SAVE_PATH = "user://"

signal game_loaded
signal game_saved

var current_save : Dictionary = {
	scene_path = "",
	player = {
		name = "",
		gold = 1,
		wood = 1,
		pos_x = 0,
		pos_y = 0	
	},
	items = [],
	persistence = [],
	quest = []
}


func save_game() -> void:
	update_player_data()
	update_scene_path()
	var file := FileAccess.open( SAVE_PATH + "save.sav", FileAccess.WRITE )
	var save_json = JSON.stringify( current_save )
	file.store_line( save_json )
	game_saved.emit()
	print("save game")
	pass
	
func load_game() -> void:
	var file := FileAccess.open( SAVE_PATH + "save.sav", FileAccess.READ )
	var json := JSON.new()
	json.parse( file.get_line() )
	var save_dict : Dictionary = json.get_data() as Dictionary
	current_save = save_dict
	
	GlobalLevelManager.load_new_level( current_save.scene_path, "", Vector2.ZERO )
	await GlobalLevelManager.level_load_started
	GlobalPlayerManager.set_player_position( Vector2( current_save.player.pos_x, current_save.player.pos_y ) )
	GlobalPlayerManager.player_name = current_save.player.name
	GlobalPlayerManager.player_stock_wood = current_save.player.wood
	GlobalPlayerManager.player_stock_gold = current_save.player.gold
	await GlobalLevelManager.level_loaded
	game_loaded.emit()
	print("load game")
	pass
	
func update_player_data() -> void:
	var p : Player	 = GlobalPlayerManager.player
	current_save.player.name = GlobalPlayerManager.player_name
	current_save.player.gold = GlobalPlayerManager.player_stock_gold
	current_save.player.wood = GlobalPlayerManager.player_stock_wood
	current_save.player.pos_x = p.global_position.x
	current_save.player.pos_y = p.global_position.y
	pass
	
func update_scene_path() -> void:
	var p : String = ""
	p = get_tree().current_scene.scene_file_path
	current_save.scene_path = p
	pass
	
