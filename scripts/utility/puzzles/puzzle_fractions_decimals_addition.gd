extends puzzle_abstract


# copyright 2021,2022 Dor "GodRabbit" Shlush
# this file is part of "BanishEmWithMath"

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

class_name puzzle_fractions_decimals_addition

var type = "+"

func generate_addition():
	type = "+"
	randomize()
	var x_nom = 1 + randi() % 1000
	var y_nom = 1 + randi() % 1000
	var solution_nom = x_nom + y_nom
	
	var x = float(x_nom)/100.0
	var y = float(y_nom)/100.0
	
	
	solution = x + y
	
	data = {"x":x, "y":y}
	
	var bank = []
	var m = int(max(int(solution_nom - 10), 0))
	for i in range(m, solution_nom + 10):
		if i != solution_nom:
			var f = float(i)/100.0
			bank.append(f)
	
	_pick_options_from_bank(bank)

func generate_subtraction():
	type = "-"
	randomize()
	var y_nom = 1 + randi() % 1000
	var solution_nom = 1 + randi() % 1000
	var x_nom = y_nom + solution_nom
	
	var x = float(x_nom)/100.0
	var y = float(y_nom)/100.0
	
	
	solution = x - y
	
	data = {"x":x, "y":y}
	
	var bank = []
	var m = int(max(int(solution_nom - 10), 0))
	for i in range(m, solution_nom + 10):
		if i != solution_nom:
			var f = float(i)/100.0
			bank.append(f)
	
	_pick_options_from_bank(bank)

func generate():
	randomize()
	var n = randi() % 2
	if n == 0:
		generate_addition()
	else:
		generate_subtraction()

func display_problem():
	return str(data["x"]) + " " + type + " " + str(data["y"]) + " = ???"
