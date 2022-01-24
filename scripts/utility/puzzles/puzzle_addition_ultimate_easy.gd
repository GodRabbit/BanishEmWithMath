extends puzzle_abstract

# copyright 2021,2022 Dor "GodRabbit" Shlush
# this file is part of "BanishEmWithMath"

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

class_name puzzle_addition_ultimate_easy
# an ultimate addition puzzle class but all the results are positive
# this class uses the ultimate_split_into function to generate problems
#  there is a setting to make all the solutions into compound answers

# how many arguments to have
var count = 3
var max_val = 100
var options_compound = false

func _init(_count = 3, _max_val = 100, _compound = false):
	count = _count
	max_val = _max_val
	options_compound = _compound

# takes arr of numbers and create a string of addition\subtraction
# between them.
#  e.g. arr = [5, -3, 4] -> "5 - 3 + 4"
func _chain_add(arr):
	var s = str(arr[0])
	for i in range(1, arr.size()):
		if arr[i] >= 0:
			s = s + (" + %d" % arr[i])
		else:
			s = s + (" - %d" % -arr[i])
	return s

func generate():
	randomize()
	solution = 5 + randi() % max_val
	
	var arr = math_util.ultimate_split_into(solution, count)
	
	data = {"arr":arr}
	
	# pick bank:
	var bank = []
	var m = int(max(solution - 10, 0))
	for i in range(m, solution + 10):
		if i != solution:
			bank.append(i)
	_pick_options_from_bank(bank)

func display_problem():
	return _chain_add(data["arr"]) + " = ???"

func display_option(val):
	if options_compound:
		var a = math_util.ultimate_split_into(val, 2)
		return _chain_add(a)
	else:
		return str(val)
