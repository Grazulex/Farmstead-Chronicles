extends Node

signal level_load_started
signal level_loaded
signal TileMapBoundsChanged( bounds : Array[ Vector2 ] )

var current_tilemap_bounds : Array[ Vector2 ]
var target_transtion : String
var position_offset : Vector2

func _ready() -> void:
	await get_tree().process_frame
	level_loaded.emit()
	pass

func ChangeTilemapBounds ( bounds : Array [ Vector2 ] ) -> void:
	current_tilemap_bounds = bounds
	TileMapBoundsChanged.emit( bounds ) 
	
func load_new_level(
	level_path : String,
	_target_transition : String,
	_position_offset : Vector2
) -> void:
	get_tree().paused = true
	target_transtion = _target_transition
	await get_tree().process_frame
	level_load_started.emit()
	await SceneTransition.fade_out()
	get_tree().change_scene_to_file( level_path )
	await SceneTransition.fade_in()
	get_tree().paused = false
	await  get_tree().process_frame
	level_loaded.emit()
	pass
