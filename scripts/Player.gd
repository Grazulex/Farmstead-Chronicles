class_name player extends CharacterBody2D

signal change_direction_x
signal initialize_sprites

@export var speed : int = 100
var last_direction : Vector2 = Vector2.ZERO

@onready var animation_player = $AnimationPlayer
@onready var skeleton = $Skeleton

func _ready():
	emit_signal("initialize_sprites")

func _physics_process(delta):
	var direction : Vector2 = Vector2.ZERO
	direction.x = Input.get_axis("ui_left", "ui_right")
	direction.y = Input.get_axis("ui_up", "ui_down")
		
	if direction.x != 0:
		velocity.x = direction.x * speed
		if direction.x > 0:
			if last_direction.x != direction.x:
				emit_signal("change_direction_x", direction.x)
			animation_player.play("walk_side")
		else:
			if last_direction.x != direction.x:
				emit_signal("change_direction_x", direction.x)
			animation_player.play("walk_side")
	else : 
		velocity.x = move_toward(velocity.x, 0, speed * delta)
		
	if direction.y != 0:
		velocity.y = direction.y * speed
		if direction.y < 0:
			animation_player.play("walk_up")
		else:
			animation_player.play("walk_down")
	else : 
		velocity.y = move_toward(velocity.y, 0, speed * delta)
		
	if direction == Vector2.ZERO:
		if last_direction.x < 0: 
			if last_direction.x != direction.x:
				emit_signal("change_direction_x", direction.x)
			animation_player.play("idle_side")
		if last_direction.x > 0:
			if last_direction.x != direction.x: 
				emit_signal("change_direction_x", direction.x)		
			animation_player.play("idle_side")	
		if last_direction.y < 0: 
			animation_player.play("idle_up")
		if last_direction.y > 0: 
			animation_player.play("idle_down")	
		else:
			animation_player.play("idle_down")	
			
	if direction != last_direction:
		last_direction = direction				
		
	move_and_slide()
