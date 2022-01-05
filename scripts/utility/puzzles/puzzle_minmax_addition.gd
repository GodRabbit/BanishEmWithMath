extends puzzle_abstract

# copyright 2021,2022 Dor "GodRabbit" Shlush
# this file is part of "BanishEmWithMath"

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

class_name puzzle_minmax_addition
# same as min\max basic but all the options + solution are
#  addition problems.

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
	solution = math_util.split_into(solution_pre, 2)
	
	options = []
	for i in range(0, 5):
		options.append(math_util.split_into(options_pre[i], 2))

func generate_max():
	_type = "max"
	# the finished sum:
	var result = math_util.pick_max_number(max_val)
	var solution_pre = result[0]
	var options_pre = result[1]
	
	# split the numbers into 2 numbers:
	solution = math_util.split_into(solution_pre, 2)
	
	options = []
	for i in range(0, 5):
		options.append(math_util.split_into(options_pre[i], 2))

func generate():
	randomize()
	var n = randi() % 2
	
	if n == 0:
		generate_min()
	else:
		generate_max()

# val is an array of size 2
func display_option(val):
	randomize()
	var num = randi() % 2
	if num == 0:
		return "%d + %d" % [val[0], val[1]]
	else:
		return "%d + %d" % [val[1], val[0]]

func display_problem():
	if _type == "min":
		return "Find The Smallest Number"
	else:
		return "Find The Biggest Number"
