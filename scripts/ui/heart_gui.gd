class_name HeartGUI extends Control

@onready var sprite: Sprite2D = $Sprite2D

var value : int = 2 : 
	set ( _value ):
		value = _value
		update_sprite()

func update_sprite() -> void:
	if value == 0:
		sprite.frame = 2
	elif value == 2:
		sprite.frame = 0
	else :
		sprite.frame = value 
