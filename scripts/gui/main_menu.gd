extends Node2D

# copyright 2021 Dor "GodRabbit" Shlush
# this file is part of "BanishEmWithMath"

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

# nodes:
onready var new_game_button = $button_container/new_game_button
onready var exit_game_button = $button_container/exit_game_button
onready var super_easy_button = $difficulty_container/super_easy_button
onready var easy_button = $difficulty_container/easy_button
onready var normal_button = $difficulty_container/normal_button
onready var hard_button = $difficulty_container/hard_button
onready var hardcore_button = $difficulty_container/hardcore_button

const BACKGROUND_MUSIC_ID = "background-loop-melodic-techno-03-2691"

# Called when the node enters the scene tree for the first time.
func _ready():
	# signals:
	new_game_button.connect("pressed", self, "on_new_game_button_pressed")
	
	# sets the button to pressed according to the last difficulty the player chose
	get_node("difficulty_container/%s_button" % player_data.prefferd_difficulty.to_lower()).pressed = true
	
	sound_manager.play_music(BACKGROUND_MUSIC_ID)


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
