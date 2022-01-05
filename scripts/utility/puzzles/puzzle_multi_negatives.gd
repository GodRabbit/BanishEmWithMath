extends puzzle_abstract

# copyright 2021,2022 Dor "GodRabbit" Shlush
# this file is part of "BanishEmWithMath"

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

class_name puzzle_multi_negatives
# a class for multiplication problems with negative numbers

var max_val = 25

func _init(_max_val = 25):
	max_val = _max_val

func generate():
	randomize()
	var x = randi() % max_val
	var y = randi() % max_val
	
	var b1 = randi() % 2
	var b2 = randi() % 2
	
	if b1 == 0:
		x  = -x
	if b2 == 0:
		y = -y
	
	data = {"x":x, "y":y}
	solution = x*y
	
	var bank = []
	for i in range(solution - 10, solution + 11):
		if i != solution:
			bank.append(i)
	
	_pick_options_from_bank(bank)

func display_problem():
	var str_x = math_util.display_number(data["x"])
	var str_y = math_util.display_number(data["y"])
	return "%sX%s = ???" % [str_x, str_y]
