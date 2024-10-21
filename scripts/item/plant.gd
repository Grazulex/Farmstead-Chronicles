class_name Plant extends Node2D

@export var damage_to_dead: int = 3
@export var value_add_stock_wood : int = 200
@export var wood_sound : AudioStream	

@onready var audio : AudioStreamPlayer2D = $Audio/AudioStreamPlayer2D


func _ready() -> void:
	$HitBox.Damaged.connect( TakeDamage )
	pass
	
func TakeDamage ( damage : int ) -> void:
	damage_to_dead -= damage
	
	audio.stream = wood_sound
	audio.pitch_scale = randf_range( 0.9,  1.1 )
	audio.play()
	await audio.finished
	
	if damage_to_dead == 0:
		GlobalPlayerManager.player_stock_wood += value_add_stock_wood
		queue_free()	
		
	pass
