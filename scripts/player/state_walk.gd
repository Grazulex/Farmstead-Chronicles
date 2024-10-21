class_name State_Walk extends State

@export var move_speed : float = 100.0

@onready var idle : State = $"../Idle"
@onready var axe : State = $"../Axe"
@onready var pickaxe: State = $"../Pickaxe"

func Enter() -> void:
	player.update_animation("walk")
	pass
	
func Exit() -> void:
	pass
	
func Process( _delta : float ) -> State:
	if player.direction == Vector2.ZERO:
		return idle
		
	player.velocity = player.direction * move_speed
	
	if player.set_direction():
		player.update_animation("walk")
	
	return null

func Physics( _delta : float ) -> State:
	return null
	
func HandelInput( _event : InputEvent ) -> State:
	if _event.is_action_pressed("axe"):
		return axe
	if _event.is_action_pressed("pickaxe"):
		return pickaxe	
	return null	

	
	
