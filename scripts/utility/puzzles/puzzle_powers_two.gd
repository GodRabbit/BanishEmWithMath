extends puzzle_abstract


# copyright 2021,2022 Dor "GodRabbit" Shlush
# this file is part of "BanishEmWithMath"

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

class_name puzzle_powers_two

var max_val
var min_val

func _init(_min_val = 2, _max_val = 12):
	max_val = _max_val
	min_val = _min_val

func generate():
	randomize()
	var power = min_val + randi() % (max_val - min_val + 1)
	data = {"power":power}
	solution = int(pow(2, power))
	
	var bank = []
	
	for i in range(min_val, max_val + 1):
		if i != power:
			bank.append(int(pow(2, i)))
	
	_pick_options_from_bank(bank)

func display_problem() -> String:
	return "2^%d = ???" % data["power"]
 
# returns a dictionary that represents how to display the problem in
# an expression_display control.
func get_display_data():
	return {"power": data["power"], "base":2}

# returns a class name of the expression_displayer that corresponds to this
#  problem. default is the string expresseion (only a string and nothing more)
func get_display_class_name():
	return "expression_power_equal"
