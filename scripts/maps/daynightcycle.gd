extends CanvasModulate

const MINUTES_PER_DAY = 1440
const MINUTES_PER_HOUR = 60
const INGAME_TO_REAL_MINUTE_DURATION = (2 * PI) / MINUTES_PER_DAY

signal time_tick(day:int, hour:int, minute:int)


@export var gradient_texture:GradientTexture1D
@export var INGAME_SPEED = 20.0
@export var INITIAL_HOUR = 12:
	set(h):
		INITIAL_HOUR = h
		time = INGAME_TO_REAL_MINUTE_DURATION * MINUTES_PER_HOUR * INITIAL_HOUR


var time:float= 0.0
var past_minute:int= -1

var day : int
var hour : int
var minute : int


func _ready() -> void:
	day = GlobalPlayerManager.player.day
	hour = GlobalPlayerManager.player.hour
	minute = GlobalPlayerManager.player.minute
	
	time = INGAME_TO_REAL_MINUTE_DURATION * MINUTES_PER_HOUR * hour


func _process(delta: float) -> void:
	time += delta * INGAME_TO_REAL_MINUTE_DURATION * INGAME_SPEED
	
	var value = (sin(time - PI / 2.0) + 1.0) / 2.0
	self.color = gradient_texture.gradient.sample(value)
	
	_recalculate_time()	

		
func _recalculate_time() -> void:
	var total_minutes = int(time / INGAME_TO_REAL_MINUTE_DURATION)
	
	day = int(total_minutes / MINUTES_PER_DAY)
	GlobalPlayerManager.player.day = day

	var current_day_minutes = total_minutes % MINUTES_PER_DAY

	hour = int(current_day_minutes / MINUTES_PER_HOUR)
	GlobalPlayerManager.player.hour = hour
	minute = int(current_day_minutes % MINUTES_PER_HOUR)
	GlobalPlayerManager.player.minute = minute
	
	PlayerHud.update_day("Day " + str(day + 1))
	PlayerHud.update_hour(_amfm_hour(hour) + ":" + _minute(minute) + " " + _am_pm(hour))	
	PlayerHud.update_arrow( hour )
		
	if past_minute != minute:
		past_minute = minute
		time_tick.emit(day, hour, minute)

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
