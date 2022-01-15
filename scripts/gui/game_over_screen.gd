extends MarginContainer

# copyright 2021,2022 Dor "GodRabbit" Shlush
# this file is part of "BanishEmWithMath"

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

# a gui element that shows up when the player dies or wins.



export var won = false # is the game 'won' or lost?

# nodes:
onready var continue_button = $main_container/continue_button
onready var game_over_lost = $main_container/game_over1
onready var game_over_won = $main_container/game_over2
onready var stars_particles = $main_container/game_over2/stars_particles
onready var hs_label = $main_container/hs_label

# Called when the node enters the scene tree for the first time.
func _ready():
	continue_button.connect("pressed", self, "on_continue_button_pressed")
	
	update_gui()


func set_won(val : bool):
	won = val
	update_gui()

func is_won():
	return won

func update_gui():
	if is_won():
		# game over but the player 'won'
		game_over_won.show()
		game_over_lost.hide()
		hs_label.show()
		stars_particles.emitting = true
	else:
		# game over because the player died without winning
		stars_particles.emitting = false
		game_over_won.hide()
		game_over_lost.show()
		hs_label.hide()

func on_continue_button_pressed():
	transition.fade_to_main_menu()
