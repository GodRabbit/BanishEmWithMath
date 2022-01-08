extends expression_display


# copyright 2021,2022 Dor "GodRabbit" Shlush
# this file is part of "BanishEmWithMath"

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

# nodes:
onready var base_label = $base_label
onready var power_label = $base_label/power_label

func update_gui():
	var dd = get_display_data()
	if dd.has("base"):
		base_label.text = str(dd["base"])
	else:
		base_label.text = ""
	if dd.has("power"):
		power_label.text = str(dd["power"])
	else:
		power_label.text = ""
