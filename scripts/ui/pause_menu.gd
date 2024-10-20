extends CanvasLayer

@onready var button_save: Button = $VBoxContainer/Button_Save
@onready var button_load: Button = $VBoxContainer/Button_Load

var is_paused : bool = false

func _ready() -> void:
	hide_pause_menu()
	button_save.pressed.connect( _on_save_pressed )
	button_load.pressed.connect( _on_load_pressed )
	pass
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("setting"):
		if is_paused == false:
			show_pause_menu()
		else:
			hide_pause_menu()
		get_viewport().set_input_as_handled()
	pass
	

func show_pause_menu() -> void:
	get_tree().paused = true
	visible = true
	is_paused = true
	button_save.grab_focus()

func hide_pause_menu() -> void:
	get_tree().paused = false
	visible = false
	is_paused = false
	

func _on_button_back_pressed() -> void:
	hide_pause_menu()
	pass


func _on_save_pressed() -> void:
	if  is_paused == false:
		return
	GlobalSaveManager.save_game()
	hide_pause_menu()
	pass


func _on_load_pressed() -> void:
	if  is_paused == false:
		return
	GlobalSaveManager.load_game()
	await GlobalLevelManager.level_load_started
	hide_pause_menu()
	pass
