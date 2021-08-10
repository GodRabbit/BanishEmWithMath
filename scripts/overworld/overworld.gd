extends Node2D


# An overworld scene that connects to combat, market and more.

var current_zone = "zone1"

# nodes:
onready var give_up_button = $give_up_button

# Called when the node enters the scene tree for the first time.
func _ready():
	
	give_up_button.connect("pressed", self, "on_give_up_button_pressed")



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func on_give_up_button_pressed():
	transition.fade_to_main_menu()
