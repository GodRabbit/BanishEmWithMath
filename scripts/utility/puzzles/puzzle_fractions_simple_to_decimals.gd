extends puzzle_abstract

# copyright 2021,2022 Dor "GodRabbit" Shlush
# this file is part of "BanishEmWithMath"

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

class_name puzzle_fractions_simple_to_decimals

# find the decimal that is equal to this simple fraction

func generate():
	randomize()
	
	# list of denominators that are easy to translate to decimals
	var den_list = math_util.get_easy_denom_list(3)
	
	var x_d = math_util._choose_random_element(den_list)
	var x_n = 1 + randi() % (x_d - 1)
	
	var x = Fraction.new(x_n, x_d)
	x.simplify()
	
	data = {"x":x}
	
	solution = x.to_float()
	
	var pivot = solution
	var bank = []
	
	for i in range(-10, 10):
		var j = pivot + 0.1*i
		if (i != 0) and (j > 0):
			bank.append(j)
	
	_pick_options_from_bank(bank)

func display_problem():
	return "%s = ???" % str(data["x"])
