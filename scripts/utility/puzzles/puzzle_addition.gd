extends "res://scripts/utility/puzzles/puzzle_abstract.gd"

# copyright 2021,2022 Dor "GodRabbit" Shlush
# this file is part of "BanishEmWithMath"

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

# an abstract puzzle of addition. create general addition problems.

class_name puzzle_addition

var max_val
var min_val

func _init(_min_val = 0, _max_val = 50):
	max_val = _max_val
	min_val = _min_val

func generate():
	randomize()
	var x = min_val + randi() % (max_val - min_val + 1)
	var y = min_val + randi() % (max_val - min_val + 1)
	data = {"x": x, "y": y}
	solution = x + y
	
	# create the wrong answers:
	
	# create a bank of options:
	var bank = []
	var min_sol = int(max(solution - 10, 0))
	for i in range(min_sol, solution + 10):
		if i != solution:
			bank.append(i)
	
	# choose a random 5 wrong answers from the bank
	_pick_options_from_bank(bank)

# returns a string that indicates how the problem will be presented
# in the displayer scene.
func display_problem() -> String:
	return "%d + %d = ???" % [data["x"], data["y"]]
