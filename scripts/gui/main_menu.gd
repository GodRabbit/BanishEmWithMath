extends Node2D


# nodes:
onready var new_game_button = $button_container/new_game_button
onready var exit_game_button = $button_container/exit_game_button


# Called when the node enters the scene tree for the first time.
func _ready():
	# signals:
	new_game_button.connect("pressed", self, "on_new_game_button_pressed")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func on_new_game_button_pressed():
	player_data.setup_player()
	transition.fade_to_overworld()
