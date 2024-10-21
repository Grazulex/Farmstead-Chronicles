class_name Stone extends Node2D

@export var damage_to_dead: int = 3
@export var stock_gold : int = 200
@export var stone_sound : AudioStream	
@export var region : Rect2
@export var player_state_name : String

@onready var audio : AudioStreamPlayer2D = $Audio/AudioStreamPlayer2D
@onready var is_broken_data: PersistentDataHandler = $IsBroken
@onready var sprite_2d: Sprite2D = $Sprite2D

var is_broken: bool = false

func _ready() -> void:
	sprite_2d.region_rect = region
	$HitBox.Damaged.connect( TakeDamage )
	is_broken_data.data_loaded.connect( set_stone_state )
	set_stone_state()
	pass
	
	
func set_stone_state() -> void:
	is_broken = is_broken_data.value
	if is_broken == true:
		queue_free()
	pass
	
func TakeDamage ( damage : int ) -> void:
	var player : Player = GlobalPlayerManager.player
	if is_broken == false && player_state_name == player.state_machine.current_state.name:
		damage_to_dead -= damage
		
		audio.stream = stone_sound
		audio.pitch_scale = randf_range( 0.9,  1.1 )
		audio.play()
		
		await audio.finished
		if damage_to_dead <= 0 && is_broken == false:
			is_broken = true
			is_broken_data.set_value()
			queue_free()	
			GlobalPlayerManager.player.update_gold(stock_gold)
		pass
