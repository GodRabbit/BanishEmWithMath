extends puzzle_abstract

# copyright 2021,2022 Dor "GodRabbit" Shlush
# this file is part of "BanishEmWithMath"

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

class_name puzzle_addition_blank

# an abstract class for addition with one addened missing (Like equations 
#  but simpler).
# examples: 3 + ____ = 6 

var max_val 
var min_val

func _init(_min_val = 0, _max_val = 20):
	max_val = _max_val
	min_val = _min_val

func generate():
	# create problem <x> + _____<solution> = <y>
	randomize()
	var x = min_val + randi() % (max_val - min_val + 1)
	solution = min_val + randi() % (max_val - min_val + 1)
	var y = x + solution
	data = {"x":x, "y":y}
	
	# create bank of wrong options:
	var bank = []
	var m = int(max(solution - 10, 0))
	for i in range(m, solution + 10):
		if i != solution:
			bank.append(i)
	
	# choose a random 5 wrong answers from the bank
	_pick_options_from_bank(bank)

func display_problem() -> String:
	randomize()
	var num = randi() % 2
	if num == 0:
		return "%d + ____ = %d" % [data["x"], data["y"]]
	else:
		return "____ + %d = %d" % [data["x"], data["y"]]
