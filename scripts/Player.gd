class_name player extends CharacterBody2D

@export var speed : int = 100
var last_direction : Vector2 = Vector2.ZERO

@onready var animation_player = $AnimationPlayer
@onready var body = $Skeleton/Body
@onready var eyes = $Skeleton/Eyes
@onready var hairs = $Skeleton/Hairs
@onready var hood = $Skeleton/Hood
@onready var clothe = $Skeleton/Clothe

func _physics_process(delta):
	var direction : Vector2 = Vector2.ZERO
	direction.x = Input.get_axis("ui_left", "ui_right")
	direction.y = Input.get_axis("ui_up", "ui_down")

	if direction != last_direction:
		last_direction = direction
		
	if direction.x != 0:
		velocity.x = direction.x * speed
		if direction.x > 0:
			body.flip_h = false
			eyes.flip_h = false
			hairs.flip_h = false
			hood.flip_h = false
			clothe.flip_h = false
			animation_player.play("walk_side")
		else:
			body.flip_h = true
			eyes.flip_h = true
			hairs.flip_h = true
			hood.flip_h = true
			clothe.flip_h = true
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
			body.flip_h = true
			eyes.flip_h = true
			hairs.flip_h = true
			hood.flip_h = true
			clothe.flip_h = true
			animation_player.play("idle_side")
		if last_direction.x > 0: 
			body.flip_h = false
			eyes.flip_h = false
			hairs.flip_h = false
			hood.flip_h = false
			clothe.flip_h = false			
			animation_player.play("idle_side")	
		if last_direction.y < 0: 
			animation_player.play("idle_up")
		if last_direction.y > 0: 
			animation_player.play("idle_down")	
		else:
			animation_player.play("idle_down")					
		
	move_and_slide()
			
