extends puzzle_abstract

# copyright 2021,2022 Dor "GodRabbit" Shlush
# this file is part of "BanishEmWithMath"

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

class_name puzzle_multi_blank
# a class for a multiplication problem where one of the multiplicants 
#  is missing.
#   example: 3*____ = 18

var max_val
var min_val

func _init(_min_val = 1, _max_val = 10):
	max_val = _max_val
	min_val = _min_val

func generate():
	# the problem is y * solution = x
	randomize()
	var y = min_val + randi() % (max_val - min_val + 1)
	var s = min_val + randi() % (max_val - min_val + 1)
	var x = y * s
	data = {"x": x, "y": y}
	solution = s
	
	# choose solutions wrong:
	var bank = []
	var m = int(max(s - 10, 0))
	for i in range(m, s + 10):
		if i != s:
			bank.append(i)
	
	_pick_options_from_bank(bank)

func display_problem() -> String:
	randomize()
	var num = randi() % 2
	if num == 0:
		return "____ X %d = %d" % [data["y"], data["x"]]
	else:
		return "%d X ____ = %d" % [data["y"], data["x"]]
