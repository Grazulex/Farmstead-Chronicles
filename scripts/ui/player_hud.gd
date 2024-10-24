extends CanvasLayer

@onready var label_name: Label = $Control/LabelName

var hearts : Array[ HeartGUI ] = []

func _ready():
	for child in $Control/HFlowContainer.get_children():
		if child is HeartGUI:
			hearts.append( child )
			child.visible = false
	pass
	
func refresh_nickname( _nickname : String) -> void:
	label_name.text = _nickname
	pass

func update_hp( _hp: int, _max_hp : int ) -> void:
	update_max_hp( _max_hp )
	for i in _max_hp:
		update_heart( i, _hp )
	pass
	
func update_heart( _index: int, _hp : int ) -> void:
	var _value : int = clampi( _hp - _index * 2, 0, 2 )
	hearts[ _index ].value = _value
	pass
	
func update_max_hp( _max_hp : int ) -> void:
	var _hear_count : int = roundi( _max_hp * 0.5 )
	for i in hearts.size():
		if i < _hear_count:
			hearts[ i ].visible = true
		else:
			hearts[ i ].visible = false
	pass
