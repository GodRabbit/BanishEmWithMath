extends puzzle_abstract


# copyright 2021,2022 Dor "GodRabbit" Shlush
# this file is part of "BanishEmWithMath"

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

class_name puzzle_percentages_to_fractions

# a bunch of numbers which will be interesting to find the fractions of
const SOLUTION_BANK = [1, 2, 4, 6, 8, 10, 12, 13, 14, 15, 18, 20, 22,
24, 25, 28, 30, 32, 35, 36, 40, 44, 45, 48, 50, 54, 55, 60,64, 65, 68, 70,
72, 75, 76, 80, 84, 85, 86, 88, 90, 94, 95, 100, 104, 105, 115, 120]

func generate():
	randomize()
	
	var bank = SOLUTION_BANK.duplicate()
	
	# this is the percentages number that will present to the player
	var sol_index = randi() % bank.size()
	var pre_solution = bank[sol_index]
	bank.remove(sol_index) # prevent re-picking
	
	data = {"x":pre_solution}
	
	solution = Fraction.new(pre_solution, 100)
	solution.simplify()
	
	# pick wrong options:
	options = []
	
	while options.size() < 5:
		var index = randi() % bank.size()
		var pre_option = bank[index]
		bank.remove(index)
		var f = Fraction.new(pre_option, 100)
		f.simplify()
		options.append(f)

func display_option(val):
	val.simplify()
	return str(val)

func display_problem():
	return str(data["x"]) + "% = ???"
