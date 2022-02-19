extends expression_display


# copyright 2021,2022 Dor "GodRabbit" Shlush
# this file is part of "BanishEmWithMath"

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

# a class for displaying the problems of common divisor
# its basically a 2 line display

# nodes:
onready var line1 = $main_container/line1
onready var line2 = $main_container/line2

func update_gui():
	var dd = get_display_data()
	line1.text = "Find a common divisor"
	line2.text = "of %d and %d" % [dd["x"], dd["y"]]
