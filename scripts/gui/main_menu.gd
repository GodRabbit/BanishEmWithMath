extends Node2D


# nodes:
onready var new_game_button = $button_container/new_game_button
onready var exit_game_button = $button_container/exit_game_button
onready var super_easy_button = $difficulty_container/super_easy_button
onready var easy_button = $difficulty_container/easy_button
onready var normal_button = $difficulty_container/normal_button
onready var hard_button = $difficulty_container/hard_button
onready var hardcore_button = $difficulty_container/hardcore_button


# Called when the node enters the scene tree for the first time.
func _ready():
	# signals:
	new_game_button.connect("pressed", self, "on_new_game_button_pressed")
	
	# sets the button to pressed according to the last difficulty the player chose
	get_node("difficulty_container/%s_button" % player_data.prefferd_difficulty.to_lower()).pressed = true
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

# returns the difficulty's id from the buttons control
func get_difficulty():
	if super_easy_button.pressed:
		return "super_easy"
	elif easy_button.pressed:
		return "easy"
	elif normal_button.pressed:
		return "normal"
	elif hard_button.pressed:
		return "hard"
	elif hardcore_button.pressed:
		return "hardcore"
	else:
		return "normal"

func on_new_game_button_pressed():
	player_data.setup_player(get_difficulty())
	player_data.prefferd_difficulty = get_difficulty()
	transition.fade_to_overworld()
