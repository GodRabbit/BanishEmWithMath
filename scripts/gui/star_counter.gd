extends MarginContainer

# copyright 2021 Dor "GodRabbit" Shlush
# this file is part of "BanishEmWithMath"

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.


# a gui for the star counter.

# nodes:
onready var number_label = $Background/Number

# Called when the node enters the scene tree for the first time.
func _ready():
	player_data.connect("stars_changed", self, "on_stars_changed")
	
	update_gui()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func update_gui():
	number_label.text = str(player_data.get_current_stars())

func on_stars_changed(v):
	update_gui()
