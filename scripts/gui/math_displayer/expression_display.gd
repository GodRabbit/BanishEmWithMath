extends Control


# copyright 2021,2022 Dor "GodRabbit" Shlush
# this file is part of "BanishEmWithMath"

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

class_name expression_display
# an 'abstract' class for displaying math elements for the puzzle displayer.

export var display_data : Dictionary

func set_display_data(_data):
	display_data = _data
	update_gui()

func get_display_data():
	return display_data

func update_gui():
	pass
