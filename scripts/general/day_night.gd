extends CanvasModulate

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var timer: Timer = $Timer
@onready var audio: AudioStreamPlayer2D = $AudioStreamPlayer2D

var day  = 0
var last_hour = 99

func _ready() -> void:
	for t in get_parent().get_children():
		if t is Timer:
			t.close
	await GlobalPlayerManager.is_node_ready()
	day = GlobalPlayerManager.player.day
	timer.start(GlobalPlayerManager.player.hour)
	timer.wait_time=360
	pass

func _process(delta: float) -> void:
	var time_passed = null
	time_passed = timer.wait_time - timer.time_left
	var animation_frame := remap( time_passed, 0 ,timer.wait_time, 0, 24 )
	var hour = int(animation_frame)
	GlobalPlayerManager.player.hour = timer.time_left
	var minute = int((animation_frame - hour)*60)
	if (hour == 0 && last_hour != hour):
		day += 1
		GlobalPlayerManager.player.day = day
	PlayerHud.update_timer(day,hour,minute)
	PlayerHud.update_arrow(hour)
	animation_player.play('day_night')
	animation_player.seek(animation_frame)
	if (last_hour != hour && hour == 22):
		audio.stream = preload("res://assets/audio/night.mp3")
		audio.play()
	if (last_hour != hour && hour == 7):
		audio.stream = preload("res://assets/audio/day.mp3")
		audio.play()		
	last_hour = hour
	


func _on_audio_stream_player_2d_finished() -> void:
	if audio.stream == preload("res://assets/audio/night.mp3"):
		audio.play()
	pass # Replace with function body.
