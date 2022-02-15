extends puzzle_abstract


# copyright 2021,2022 Dor "GodRabbit" Shlush
# this file is part of "BanishEmWithMath"

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

class_name puzzle_fractions_decimals_division

func generate():
	randomize()
	var y_pre = rand_range(0.01, 10.0)
	var solution_pre = rand_range(0.01, 10.0)
	
	var y = int(y_pre*10.0)/10.0
	solution = int(solution_pre*10.0)/10.0
	
	
	var x = solution * y
	
	data = {"x":x, "y":y}
	
	var pivot = solution
	var bank = []
	
	for i in range(-10, 10):
		var j = pivot + 0.1*i
		if (i != 0) and (j > 0):
			bank.append(j)
	
	_pick_options_from_bank(bank)

func display_problem():
	return str(data["x"]) + " : " + str(data["y"]) + " = ???"
