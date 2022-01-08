extends expression_display


# copyright 2021,2022 Dor "GodRabbit" Shlush
# this file is part of "BanishEmWithMath"

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

# nodes:
onready var exprsn_power = $main_container/expression_power

func update_gui():
	var dd = get_display_data()
	exprsn_power.set_display_data(dd)
