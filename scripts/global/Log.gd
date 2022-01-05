extends Node


# copyright 2021,2022 Dor "GodRabbit" Shlush
# this file is part of "BanishEmWithMath"

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

# A global class for logging info into a file.
# use log_print from anywhere to write to the log


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func log_print(data : String):
	if game_settings.get_setting("game_data")["debug_mode"]:
		# Get the date stamp:
		var time = OS.get_datetime()
		print("[%02d:%02d:%02d] %s" % [time.hour, time.minute, time.second, data])
		
	return true
