extends HBoxContainer

# copyright 2021,2022 Dor "GodRabbit" Shlush
# this file is part of "BanishEmWithMath"

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

# a scene for the player's hp bar
# Add hearts as the player's max hp
# 

const HEART_SINGLE = preload("res://scenes/gui/heart_single.tscn")

var hearts_array = []

# is the hp bar has skulls instead of hearts??
export var alternate = false

# Called when the node enters the scene tree for the first time.
func _ready():
	player_data.connect("hp_changed", self, "update_gui")
	if player_data.get_new_game() > 0:
		alternate = true
	else:
		alternate = false
	update_max_hp()

# updates the amount of hearts
func update_max_hp():
	# remove the current hearts
	hearts_array = []
	for c in get_children():
		remove_child(c)
		c.queue_free()
	
	# add new hearts:
	for i in range(0, player_data.get_max_hp()):
		var h = HEART_SINGLE.instance()
		hearts_array.append(h)
		add_child(h)
	
	update_gui()

func set_alternate(val : bool):
	alternate = val
	update_gui()

# updates the health
func update_gui():
	for i in range(0, player_data.get_max_hp()):
		hearts_array[i].set_alternate(alternate)
		if i < player_data.get_current_hp():
			hearts_array[i].set_state(true) # fill the heart
		else:
			hearts_array[i].set_state(false) # fill the heart
	
	# if the player has only 1 hp, set the 1st heart in the array as last heart
	if player_data.get_current_hp() == 1:
		hearts_array[0].set_last_heart(true)
	else:
		hearts_array[0].set_last_heart(false)


