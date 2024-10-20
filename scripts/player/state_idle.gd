class_name State_Idle extends State

@onready var walk : State = $"../Walk"
@onready var axe: State = $"../Axe"

func Enter() -> void:
	player.update_animation("idle")
	pass
	
func Exit() -> void:
	pass
	
func Process( _delta : float ) -> State:
	if player.direction != Vector2.ZERO:
		return walk
	player.velocity = Vector2.ZERO
	return null

func Physics( _delta : float ) -> State:
	return null
	
func HandelInput( _event : InputEvent ) -> State:
	if _event.is_action_pressed("axe"):
		return axe
	return null	

	
	
