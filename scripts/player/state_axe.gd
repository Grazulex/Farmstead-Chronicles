class_name State_Axe extends State

@export var axe_sound : AudioStream	
@export_range( 1, 20 , 0.5 ) var decelerate_speed : float = 5.0 

@onready var walk : State = $"../Walk"
@onready var idle: State = $"../Idle"

@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"
@onready var audio: AudioStreamPlayer2D = $"../../Audio/AudioStreamPlayer2D"
@onready var hurt_box: HurtBox = $"../../Interactions/HurtBox"

var axing: bool = false

func Enter() -> void:
	player.update_animation("axe")
	animation_player.animation_finished.connect( EndAxe )
	audio.stream = axe_sound
	audio.pitch_scale = randf_range( 0.9,  1.1 )
	audio.play()
	axing = true
	await get_tree().create_timer( 0.075 ).timeout
	hurt_box.monitoring = true
	pass
	
func Exit() -> void:
	animation_player.animation_finished.disconnect( EndAxe )
	axing = false
	hurt_box.monitoring = false
	pass
	
func Process( _delta : float ) -> State:
	player.velocity -= player.velocity * decelerate_speed * _delta
	if axing == false:
		if player.direction == Vector2.ZERO:
			return idle
		else:
			return walk
	return null

func Physics( _delta : float ) -> State:
	return null
	
func HandelInput( _event : InputEvent ) -> State:
	return null	

func EndAxe( _newAnimName: String ) -> void:
	axing = false
	
	
