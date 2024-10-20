class_name Map_001 extends Node2D

@export var limit_layer: TileMapLayer

func _ready():
	GlobalLevelManager.ChangeTilemapBounds( GetTilemapBounds() )
	pass


func GetTilemapBounds() -> Array[ Vector2 ]:
	var bounds : Array[ Vector2 ] = []
	bounds.append(
		Vector2( limit_layer.get_used_rect().position * limit_layer.rendering_quadrant_size )
	)

	bounds.append(
		Vector2 ( limit_layer.get_used_rect().end  * limit_layer.rendering_quadrant_size )
	)
	return bounds
