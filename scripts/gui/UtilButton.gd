extends Button

# copyright 2021,2022 Dor "GodRabbit" Shlush
# this file is part of "BanishEmWithMath"

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

# A button used for this game. 

class_name UtilButton

export var sound_id = "none"

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("pressed", self, "on_pressed")


func on_pressed():
	sound_manager.play_ui_sound(sound_id)
