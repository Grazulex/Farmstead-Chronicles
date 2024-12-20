class_name Player extends CharacterBody2D

signal change_direction_x
signal initialize_sprites
signal direction_changed( new_direction: Vector2 )

const DIR_4 = [ Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT, Vector2.UP ]

var cardinal_direction : Vector2 = Vector2.DOWN
var direction : Vector2 = Vector2.ZERO

@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var skeleton = $Skeleton
@onready var state_machine : PlayerStateMachine = $StateMachine

var nickname : String = "Nina"
var hp : int = 2
var max_hp : int = 10
var day : int = 0
var hour : float = 0

func _ready():
	emit_signal("initialize_sprites")
	state_machine.Initialize(self)
	update_hp(0)
	update_nickname( nickname )
	pass
	
func _process(_delta):
	direction = Vector2(
		Input.get_axis("ui_left", "ui_right"),
		Input.get_axis("ui_up", "ui_down")
	).normalized()
	pass
	
func _physics_process(_delta):
	move_and_slide()

func set_direction() -> bool:
	var new_direction : Vector2 = cardinal_direction
	if direction == Vector2.ZERO:
		return false
		
	if direction.y == 0:
		new_direction = Vector2.LEFT if direction.x < 0 else Vector2.RIGHT
	elif direction.x == 0:
		new_direction = Vector2.UP if direction.y < 0 else Vector2.DOWN
		
	if new_direction == cardinal_direction:
		return false
	
	cardinal_direction = new_direction
	direction_changed.emit( new_direction )
	if cardinal_direction.x != 0:
		emit_signal("change_direction_x", direction.x)
	return true


func update_animation( state : String ) -> void:
	animation_player.play(state + "_" + anim_direction())
	pass
	
func anim_direction() -> String:
	if cardinal_direction == Vector2.DOWN:
		return "down"
	elif cardinal_direction == Vector2.UP:
		return "up"	
	else:
		return "side"
		
func update_nickname (new_nickname : String) -> void:
	nickname = new_nickname
	PlayerHud.refresh_nickname( nickname )
		
func update_hp (delta : int) -> void:
	hp  = clampi( hp + delta, 0, max_hp)
	PlayerHud.update_hp( hp , max_hp )
	pass
