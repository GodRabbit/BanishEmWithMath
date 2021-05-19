extends Node2D


# An overworld scene that connects to combat, market and more.

# nodes:
onready var farm_button = $site_container/farm_button
onready var ocean_button = $site_container/ocean_button
onready var jungle_button = $site_container/jungle_button
onready var cemetery_button = $site_container/cemetery_button
onready var white_board_button = $site_container/white_board_button

onready var give_up_button = $give_up_button

# Called when the node enters the scene tree for the first time.
func _ready():
	farm_button.connect("pressed", self, "on_farm_button_pressed")
	ocean_button.connect("pressed", self, "on_ocean_button_pressed")
	jungle_button.connect("pressed", self, "on_jungle_button_pressed")
	cemetery_button.connect("pressed", self, "on_cemetery_button_pressed")
	white_board_button.connect("pressed", self, "on_white_board_button_pressed")
	
	give_up_button.connect("pressed", self, "on_give_up_button_pressed")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func on_farm_button_pressed():
	transition.fade_to_combat("farm")

func on_ocean_button_pressed():
	transition.fade_to_combat("ocean")

func on_jungle_button_pressed():
	transition.fade_to_combat("jungle")

func on_cemetery_button_pressed():
	transition.fade_to_combat("cemetery")

func on_white_board_button_pressed():
	transition.fade_to_combat("the_white_board")

func on_give_up_button_pressed():
	transition.fade_to_main_menu()
