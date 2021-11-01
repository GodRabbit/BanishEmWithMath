extends MarginContainer

# copyright 2021 Dor "GodRabbit" Shlush
# this file is part of "BanishEmWithMath"

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

# a gui element that shows up when the player dies.

# nodes:
onready var continue_button = $main_container/continue_button

# Called when the node enters the scene tree for the first time.
func _ready():
	continue_button.connect("pressed", self, "on_continue_button_pressed")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func on_continue_button_pressed():
	transition.fade_to_main_menu()
