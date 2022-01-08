extends expression_display

# copyright 2021,2022 Dor "GodRabbit" Shlush
# this file is part of "BanishEmWithMath"

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

# a gui class that represents a problem as a simple string.

# nodes:
onready var problem_label = $problem_label

func update_gui():
	problem_label.text = get_display_data()["str"]
