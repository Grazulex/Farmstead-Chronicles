class_name Plant extends Node2D

@export var damage_to_dead: int = 3
@export var stock_wood : int = 200
@export var wood_sound : AudioStream	

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
	if is_cut == false:
		damage_to_dead -= damage
		
		audio.stream = wood_sound
		audio.pitch_scale = randf_range( 0.9,  1.1 )
		audio.play()
		
		await audio.finished
		
		if damage_to_dead == 0 && is_cut == false:
			is_cut = true
			is_cut_data.set_value()
			queue_free()	
			GlobalPlayerManager.player.update_wood(stock_wood)
		pass
