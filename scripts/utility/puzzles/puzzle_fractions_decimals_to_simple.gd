extends puzzle_abstract


# copyright 2021,2022 Dor "GodRabbit" Shlush
# this file is part of "BanishEmWithMath"

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.


class_name puzzle_fractions_decimals_to_simple

# TODO: this is  a very simplified and not so satisfactory way to do
# these problems.
func generate():
	randomize()
	var nominator = 1 + randi() % 1000
	var x = float(nominator)/100.0
	data={"x":x}
	solution = Fraction.new(nominator, 100)
	solution.simplify()
	
	var bank = []
	var m = int(min(int(nominator - 15), 0))
	for i in range(m, nominator + 16):
		var f = Fraction.new(i, 100)
		f.simplify()
		if i != nominator:
			bank.append(f)
	
	_pick_options_from_bank(bank)

func display_option(val):
	val.simplify()
	return str(val)

func display_problem():
	return str(data["x"]) + " = ???"
