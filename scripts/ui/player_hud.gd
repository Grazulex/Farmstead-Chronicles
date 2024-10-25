extends CanvasLayer

@onready var sprite_2d_2: Sprite2D = $TimeUI/Sprite2D2
@onready var sprite_arrow: Sprite2D = $TimeUI/SpriteArrow
@onready var sprite_2d: Sprite2D = $TimeUI/Sprite2D
@onready var label_day: Label = $TimeUI/LabelDay
@onready var label_hour: Label = $TimeUI/LabelHour


@onready var label_name: Label = $HpUI/LabelName


var hearts : Array[ HeartGUI ] = []

func _ready():
	for child in $HpUI/HFlowContainer.get_children():
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
	
func update_timer(day : int, hour : int, minute : int) -> void:
	label_day.text = "Day " + str(day + 1)
	label_hour.text = _amfm_hour(hour) + ":" + _minute(minute) + " " + _am_pm(hour)
	update_arrow( hour )
	pass
	
func update_heart( _index: int, _hp : int ) -> void:
	var _value : int = clampi( _hp - _index * 2, 0, 2 )
	hearts[ _index ].value = _value
	pass
	
func update_arrow(hour : int) -> void:
	if hour <= 12:
		sprite_arrow.rotation_degrees = _remap_rangef(hour, 0, 12, -90, 90)
	else :
		sprite_arrow.rotation_degrees = _remap_rangef(hour, 13, 23, 90, -90)
	
func update_max_hp( _max_hp : int ) -> void:
	var _hear_count : int = roundi( _max_hp * 0.5 )
	for i in hearts.size():
		if i < _hear_count:
			hearts[ i ].visible = true
		else:
			hearts[ i ].visible = false
	pass
	
func _amfm_hour(hour:int) -> String:
	if hour == 0:
		return str(12)
	if hour > 12:
		return str(hour - 12)
	return str(hour)


func _minute(minute:int) -> String:
	if minute < 10:
		return "0" + str(minute)
	return str(minute)


func _am_pm(hour:int) -> String:
	if hour < 12:
		return "am"
	else:
		return "pm"	

func _remap_rangef(input:float, minInput:float, maxInput:float, minOutput:float, maxOutput:float):
	return float(input - minInput) / float(maxInput - minInput) * float(maxOutput - minOutput) + minOutput		
