extends HBoxContainer

# copyright 2021,2022 Dor "GodRabbit" Shlush
# this file is part of "BanishEmWithMath"

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

# a ui class for displaying a single 'High Score' entry

var entry : hs_entry
var index = 0 # the index 
export var empty = true

# nodes:
onready var main_label = $main_label
onready var stars_label = $stars_label
onready var stars_texture = $stars_texture

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func set_entry(_entry,_index, _empty):
	entry = _entry
	empty = _empty
	index = _index
	update_gui()

func set_empty(val : bool):
	empty = val
	update_gui()

func get_entry():
	return entry

func get_index():
	return index

func update_gui():
	if !empty:
		var s = str(get_entry())
		main_label.text = "%d. %s ; " % [index + 1, s]
		stars_label.text = str(entry.get_stars())
		stars_texture.show()
	else:
		main_label.text = "%d. " % (index + 1)
		stars_label.text = ""
		stars_texture.hide()
		
	
