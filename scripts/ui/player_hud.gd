extends CanvasLayer

@onready var label_name = $PanelContainer/VSplitContainer/LabelName
@onready var label_wood = $PanelContainer/VSplitContainer/GridContainer/LabelWood
@onready var label_gold = $PanelContainer/VSplitContainer/GridContainer/LabelGold


func _ready():
	label_name.text = GlobalPlayerManager.player.nickname
	refresh_stock_gold()
	refresh_stock_wood()
	pass
	
func _process(_delta):
	pass
	
func update_all() -> void :
	refresh_stock_gold()
	refresh_stock_wood()

func refresh_stock_wood() -> void :
	label_wood.text = str(GlobalPlayerManager.player.wood)
	
func refresh_stock_gold() -> void :
	label_gold.text = str(GlobalPlayerManager.player.gold)

func refresh_stock_hp() -> void:
	print("show hp", str(GlobalPlayerManager.player.hp))
	pass
	
func refresh_nickname() -> void:
	label_name.text = str(GlobalPlayerManager.player.nickname)

func _on_button_settings_pressed() -> void:
	PauseMenu.show_pause_menu()
	pass # Replace with function body.
