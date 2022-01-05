extends puzzle_abstract

# copyright 2021,2022 Dor "GodRabbit" Shlush
# this file is part of "BanishEmWithMath"

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

class_name puzzle_multi_simple

var max_val
var min_val

func _init(_min_val = 1, _max_val = 10):
	max_val = _max_val
	min_val = _min_val

func generate():
	randomize()
	var y = min_val + randi() % (max_val - min_val + 1)
	var x = min_val + randi() % (max_val - min_val + 1)
	data = {"x": x, "y": y}
	var s = x * y
	solution = s
	
	# create the wrong answers:
	
	var bank = [] # bank of wrong answers
	# create a bank of options:
	for i in range(1, 3):
		_check_and_add(bank, s + i)
		_check_and_add(bank, s - i)
		_check_and_add(bank, x * (y + i))
		_check_and_add(bank, x * (y - i))
		_check_and_add(bank, (x + i)*y)
		_check_and_add(bank, (x - i)*y)
	
	# if the bank is too small, add garbage to it:
	if bank.size() < 5:
		var m = int(max(s - 20, 0))
		for i in range(m, s + 20):
			if i != s:
				_check_and_add(bank, i)
	
	_pick_options_from_bank(bank)

# returns a string that indicates how the problem will be presented
# in the displayer scene.
func display_problem() -> String:
	return "%d X %d = ???" % [data["x"], data["y"]]
