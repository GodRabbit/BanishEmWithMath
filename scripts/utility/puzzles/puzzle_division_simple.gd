extends "res://scripts/utility/puzzles/puzzle_abstract.gd"

# copyright 2021,2022 Dor "GodRabbit" Shlush
# this file is part of "BanishEmWithMath"

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

class_name puzzle_division_simple

var max_val = 12

func _init(_max_val = 12):
	max_val = _max_val

func generate():
	randomize()
	var y = 1 + randi() % max_val
	var s = randi() % max_val
	var x = y * s
	data = {"x": x, "y": y}
	solution = s
	
	# generate the bank of wrong answers
	var bank = []
	for i in range(1, 4):
		_check_and_add(bank, s + i)
		_check_and_add(bank, s - i)
		
		var y_fake = y - i
		var s_fake 
		if y_fake != 0:
			s_fake = int(x/y_fake)
			if s_fake != s:
				_check_and_add(bank, s_fake)
		
		y_fake = y + i
		if y_fake != 0:
			s_fake = int(x/y_fake)
			if s_fake != s:
				_check_and_add(bank, s_fake)
	
	# bank may have too few options, fix it: 
	if bank.size() < 5:
		var m = int(max(s - 10, 0))
		for i in range(m, s + 10):
			if i != s:
				_check_and_add(bank, i)
	_pick_options_from_bank(bank)

# returns a string that indicates how the problem will be presented
# in the displayer scene.
func display_problem() -> String:
	return "%d : %d = ???" % [data["x"], data["y"]]
