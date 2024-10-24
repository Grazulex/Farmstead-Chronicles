@tool
class_name ItemPickup extends Node2D

@export var item_data : itemData : set = _set_item_data

@onready var area_2d: Area2D = $Area2D
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var is_use_data : PersistentDataHandler = $IsUse

var is_use : bool = false

func _ready() -> void:
	_update_texture()
	if Engine.is_editor_hint():
		return
	
	area_2d.body_entered.connect( _on_body_entered )	
	is_use_data.data_loaded.connect( set_item_state )
	set_item_state()
	pass
	
func set_item_state() -> void:
	is_use = is_use_data.value
	if is_use == true:
		queue_free()
	pass
	
func _on_body_entered( b ) -> void:
	if b is Player:
		if item_data:
			if GlobalPlayerManager.INVENTORY_DATA.add_item( item_data ) == true:
				item_picked_up()
	pass

func item_picked_up()  -> void:
	area_2d.body_entered.disconnect( _on_body_entered )
	audio_stream_player_2d.play()
	visible = false
	await audio_stream_player_2d.finished
	is_use = true
	is_use_data.set_value()
	queue_free()
	pass	
	
func _set_item_data( value : itemData) -> void:
	item_data = value
	_update_texture()
	pass

func _update_texture()  -> void:
	if item_data and sprite_2d:
		sprite_2d.texture = item_data.texture
	pass
