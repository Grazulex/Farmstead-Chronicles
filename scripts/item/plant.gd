class_name Plant extends Node2D

@export var item_data : itemData : set = _set_item_data

@export var damage_to_dead: int = 3
@export var wood_sound : AudioStream	
@export var player_state_name : String

@onready var audio : AudioStreamPlayer2D = $Audio/AudioStreamPlayer2D
@onready var is_cut_data: PersistentDataHandler = $IsCut

var is_cut: bool = false

func _ready() -> void:
	$HitBox.Damaged.connect( TakeDamage )
	is_cut_data.data_loaded.connect( set_plant_state )
	set_plant_state()
	pass
	
	
func set_plant_state() -> void:
	is_cut = is_cut_data.value
	if is_cut == true:
		queue_free()
	pass
	
func TakeDamage ( damage : int ) -> void:
	var player : Player = GlobalPlayerManager.player
	if is_cut == false && player_state_name == player.state_machine.current_state.name:
		damage_to_dead -= damage
		
		audio.stream = wood_sound
		audio.pitch_scale = randf_range( 0.9,  1.1 )
		audio.play()
		
		await audio.finished
		
		if damage_to_dead <= 0 && is_cut == false:
			if GlobalPlayerManager.INVENTORY_DATA.add_item( item_data ) == true:
				is_cut = true
				is_cut_data.set_value()
				queue_free()
		pass

func _set_item_data( value : itemData) -> void:
	item_data = value
	pass
