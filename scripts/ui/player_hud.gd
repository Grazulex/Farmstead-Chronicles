extends CanvasLayer

@onready var label_name = $PanelContainer/VSplitContainer/LabelName
@onready var label_wood = $PanelContainer/VSplitContainer/GridContainer/LabelWood
@onready var label_gold = $PanelContainer/VSplitContainer/GridContainer/LabelGold


func _ready():
	label_name.text = GlobalPlayerManager.player_name
	refresh_stock_gold()
	refresh_stock_wood()
	pass
	
func _process(_delta):
	pass

func refresh_stock_wood():
	label_wood.text = str(GlobalPlayerManager.player_stock_wood)
	
func refresh_stock_gold():
	label_gold.text = str(GlobalPlayerManager.player_stock_gold)

func _on_button_settings_pressed() -> void:
	PauseMenu.show_pause_menu()
	pass # Replace with function body.
