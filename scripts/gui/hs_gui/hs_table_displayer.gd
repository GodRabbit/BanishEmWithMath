extends Control

# copyright 2021,2022 Dor "GodRabbit" Shlush
# this file is part of "BanishEmWithMath"

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

# a gui scene for displaying the "high scores" table

# nodes:
onready var exit_button = $main_vcontainer/main_panel/main_container/entry_container/exit_button

# signals:
signal request_exit


# Called when the node enters the scene tree for the first time.
func _ready():
	exit_button.connect("pressed", self, "on_exit_button_pressed")
	
	update_gui()

# update gui before showing itself.
func show():
	update_gui()
	.show()

func update_gui():
	var entries_size = hs_data.get_entries_size("zone1")
	for i in range(0, 5):
		var entry_display = get_node("main_vcontainer/main_panel/main_container/entry_container/hs_entry_displayer%d" % i)
		if i < entries_size:
			entry_display.set_entry(hs_data.get_score("zone1", i), i, false)
		else:
			entry_display.set_entry(hs_entry.new("", "", 0, 0, OS.get_datetime()), i, true)

func on_exit_button_pressed():
	emit_signal("request_exit")
