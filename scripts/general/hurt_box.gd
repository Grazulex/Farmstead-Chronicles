class_name HurtBox extends Area2D

@export var damage : int = 1
@onready var audio : AudioStreamPlayer2D = $"../../Audio/AudioStreamPlayer2D"

func _ready() -> void:
	area_entered.connect( AreaEntered )
	pass 


func _process(delta: float) -> void:
	pass

func AreaEntered( a : Area2D) -> void:
	if a is HitBox:
		a.take_damage( damage )
	pass
