class_name Plant extends Node2D

@export var damage_to_dead: int = 3
@export var value_add_stock_wood : int = 200

func _ready() -> void:
	$HitBox.Damaged.connect( TakeDamage )
	pass
	
func TakeDamage ( damage : int ) -> void:
	damage_to_dead -= damage
	if damage_to_dead == 0:
		queue_free()
	pass
