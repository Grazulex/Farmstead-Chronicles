extends Node

const SAVE_PATH = "user://"

signal game_loaded
signal game_saved

var current_save : Dictionary = {
	scene_path = "",
	player = {
		nickname = "",
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
	
	GlobalPlayerManager.player.nickname = current_save.player.nickname
	GlobalPlayerManager.player.wood = current_save.player.wood
	GlobalPlayerManager.player.gold = current_save.player.gold
	
	PlayerHud.update_all()
	await GlobalLevelManager.level_loaded
	game_loaded.emit()
	print("load game")
	pass
	
func update_player_data() -> void:
	var p : Player	 = GlobalPlayerManager.player
	current_save.player.nickname = p.nickname
	current_save.player.gold = p.gold
	current_save.player.wood = p.wood
	current_save.player.pos_x = p.global_position.x
	current_save.player.pos_y = p.global_position.y
	pass
	
func update_scene_path() -> void:
	var p : String = ""
	for c in get_tree().root.get_children():
		if c is Level:
			p = c.scene_file_path
	current_save.scene_path = p
	pass
	
func add_persistent_value( value : String ) -> void:
	if check_persistent_value( value ) == false:
		current_save.persistence.append( value )
	pass
	
func check_persistent_value (value : String ) -> bool:
	var p = current_save.persistence as Array
	return p.has( value )
