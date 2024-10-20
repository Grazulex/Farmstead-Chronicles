class_name State_Axe extends State

@onready var walk : State = $"../Walk"
@onready var idle: State = $"../Idle"
@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"

var axing: bool = false

func Enter() -> void:
	player.update_animation("axe")
	animation_player.animation_finished.connect( EndAxe )
	axing = true
	pass
	
func Exit() -> void:
	animation_player.animation_finished.disconnect( EndAxe )
	pass
	
func Process( _delta : float ) -> State:
	player.velocity = Vector2.ZERO
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
	
	
