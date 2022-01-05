extends puzzle_abstract

# copyright 2021,2022 Dor "GodRabbit" Shlush
# this file is part of "BanishEmWithMath"

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

class_name puzzle_minmax_subtraction
# same as min\max basic but all the options + solution are
#  addition\subtraction problems.

# "min" for minimum problem. "max" is for maximum problems.
var _type = "min"

var max_val = 100

# whats the smallest max_val possible.
const MIN_MAX_VAL = 6

func _init(_max_val = 100):
	max_val = _max_val


func generate_min():
	_type = "min"
	# the finished sum:
	var result = math_util.pick_min_number(max_val)
	var solution_pre = result[0]
	var options_pre = result[1]
	
	# split the numbers into 2 numbers:
	solution = math_util.ultimate_split_into(solution_pre, 2)
	
	options = []
	for i in range(0, 5):
		options.append(math_util.ultimate_split_into(options_pre[i], 2))

func generate_max():
	_type = "max"
	# the finished sum:
	var result = math_util.pick_max_number(max_val)
	var solution_pre = result[0]
	var options_pre = result[1]
	
	# split the numbers into 2 numbers:
	solution = math_util.ultimate_split_into(solution_pre, 2)
	
	options = []
	for i in range(0, 5):
		options.append(math_util.ultimate_split_into(options_pre[i], 2))

func display_problem():
	if _type == "min":
		return "Find The Smallest Number"
	else:
		return "Find The Biggest Number"

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
	var n = randi() % 2
	
	if n == 0:
		generate_min()
	else:
		generate_max()

func display_option(val):
	return _chain_add(val)
