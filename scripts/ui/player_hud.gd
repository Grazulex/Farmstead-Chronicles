class_name PLayerHud extends Node

@onready var label_name = $PanelContainer/VSplitContainer/LabelName
@onready var label_wood = $PanelContainer/VSplitContainer/GridContainer/LabelWood
@onready var label_gold = $PanelContainer/VSplitContainer/GridContainer/LabelGold


# Called when the node enters the scene tree for the first time.
func _ready():
	label_name.text = GlobalPlayerManager.player_name
	refresh_stock_gold()
	refresh_stock_wood()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func refresh_stock_wood():
	label_wood.text = str(GlobalPlayerManager.player_stock_wood)
	
func refresh_stock_gold():
	label_gold.text = str(GlobalPlayerManager.player_stock_gold)

