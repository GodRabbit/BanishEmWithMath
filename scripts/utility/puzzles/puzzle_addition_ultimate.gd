extends "res://scripts/utility/puzzles/puzzle_abstract.gd"

# copyright 2021,2022 Dor "GodRabbit" Shlush
# this file is part of "BanishEmWithMath"

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

class_name puzzle_addition_ultimate
# addition\subtraction with negatives and more than one number added

var max_val = 20

# how many numners we add\subtract
var min_count = 2
var max_count = 5

func _init(_max_val = 20, _min_count = 2, _max_count = 4):
	max_val = _max_val
	min_count = _min_count
	max_count = _max_count

# pick a number between [-max_absolute, +max_max_absolute]
# unless its zero.
func _pick_number(max_absolute):
	var n = 1 + randi() % max_val
	var b = randi() % 2
	if b == 0: # will the number be positive or negative?
		n = -n
	return n

func generate():
	var count = min_count + randi() % (max_count - min_count + 1)
	
	var numbers = []
	var ops = [] # operations
	solution = 0
	
	# choose the 1st number
	var first = _pick_number(max_val)
	numbers.append(first)
	solution = first
	
	for i in range(1, count):
		var n = _pick_number(max_val)
		
		# choose operator
		var b = randi() % 2
		if b == 0:
			ops.append("-")
			solution = solution - n
		else:
			ops.append("+")
			solution = solution + n
		
		numbers.append(n)
	
	data = {"numbers":numbers, "ops":ops, "solution":solution}
	
	var bank = []
	for i in range(solution - 30, solution + 31):
		if i != solution:
			bank.append(i)
	
	_pick_options_from_bank(bank)

func display_problem():
	var result = ""
	
	result += math_util.display_number(data["numbers"][0])
	
	for i in range(1, data["numbers"].size()):
		result += data["ops"][i - 1]
		result += math_util.display_number(data["numbers"][i])
	
	result += " = ???"
	return result
