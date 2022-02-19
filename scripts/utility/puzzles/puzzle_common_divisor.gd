extends puzzle_abstract


# copyright 2021,2022 Dor "GodRabbit" Shlush
# this file is part of "BanishEmWithMath"

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

class_name puzzle_common_divisor

var max_val

func _init(_val):
	max_val = _val

func generate():
	randomize()
	
	var divisor = 2 + randi() % (max_val - 1)
	
	var numbers = range(2, max_val + 1)
	
	# pick a random number for y: (prevent duplication with x
	var index = randi() % numbers.size()
	
	var y_pre = numbers[index]
	numbers.remove(index)
	
	# choose a random number for x that is different from y:
	index = randi() % numbers.size()
	var x_pre = numbers[index]
	
	var x = x_pre*divisor
	var y = y_pre*divisor
	
	data = {"x": x, "y":y}
	solution = divisor
	
	var bank = []
	
	for i in range(2, max_val):
		# only add to the bank the numbers that are not divisble by both
		# x and y
		if x % i != 0 || y % i != 0:
			bank.append(i)
	
	if bank.size() < 5:
		for i in range(2, 2*max_val):
			# only add to the bank the numbers that are not divisble by both
			# x and y
			if x % i != 0 || y % i != 0:
				bank.append(i)
	
	_pick_options_from_bank(bank)

func display_problem():
	return "Find a common divisor of %d and %d" % [data["x"], data["y"]]

func get_display_data():
	return data

# returns a class name of the expression_displayer that corresponds to this
#  problem. default is the string expresseion (only a string and nothing more)
func get_display_class_name():
	return "expression_common_divisor"
