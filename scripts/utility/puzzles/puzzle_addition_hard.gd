extends "res://scripts/utility/puzzles/puzzle_abstract.gd"

# copyright 2021,2022 Dor "GodRabbit" Shlush
# this file is part of "BanishEmWithMath"

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

# DEPRECATED
# an abstract puzzle of addition. create general addition problems

#class_name puzzle_addition_hard

func generate():
	randomize()
	var x = randi() % 1000
	var y = randi() % 1000
	data = {"x": x, "y": y}
	solution = x + y
	
	# create the wrong answers:
	
	# create a bank of options:
	var bank = []
	for i in range(solution - 10, solution + 10):
		if i != solution:
			bank.append(i)
	
	# choose a random 5 wrong answers from the bank
	_pick_options_from_bank(bank)

# returns a string that indicates how the problem will be presented
# in the displayer scene.
func display_problem() -> String:
	return "%d + %d = ???" % [data["x"], data["y"]]
