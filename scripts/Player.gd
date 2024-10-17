class_name Player extends CharacterBody2D

signal change_direction_x
signal initialize_sprites
signal direction_changed( new_direction: Vector2 )

const DIR_4 = [ Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT, Vector2.UP ]

@export var speed : float = 100.0
var cardinal_direction : Vector2 = Vector2.DOWN
var direction : Vector2 = Vector2.ZERO
var state : String = "idle"

@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var skeleton = $Skeleton

func _ready():
	emit_signal("initialize_sprites")
	
func _process(delta):

	direction.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	direction.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	velocity = direction * speed
	
	if set_state() == true || set_direction() == true:
		update_animation()
		
	pass
func _physics_process(delta):
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
	if cardinal_direction.x != 0:
		emit_signal("change_direction_x", direction.x)
	return true

	
func set_state() -> bool:
	var new_state : String = "idle" if direction == Vector2.ZERO else "walk"
	if new_state == state:
		return false
	state = new_state
	return true
	
	
func update_animation() -> void:
	animation_player.play(state + "_" + anim_direction())
	pass
	
func anim_direction() -> String:
	if cardinal_direction == Vector2.DOWN:
		return "down"
	elif cardinal_direction == Vector2.UP:
		return "up"
	else:
		return "side"
