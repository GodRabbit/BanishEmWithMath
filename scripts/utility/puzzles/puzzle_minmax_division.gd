extends puzzle_abstract

# copyright 2021,2022 Dor "GodRabbit" Shlush
# this file is part of "BanishEmWithMath"

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

class_name puzzle_minmax_division

var _type = "min"
var max_val = 10

func _init(_max_val = 10):
	max_val = _max_val

func generate_min():
	_type = "min"
	
	var result = math_util.pick_min_number(max_val)
	var solution_pre = result[0]
	var options_pre = result[1]
	
	var num = 1 + randi() % max_val
	solution = [num*solution_pre, num]
	
	options = []
	for i in range(0, 5):
		num = 1 + randi() % max_val
		options.append([options_pre[i]*num, num])

func generate_max():
	_type = "max"
	
	var result = math_util.pick_max_number(max_val)
	var solution_pre = result[0]
	var options_pre = result[1]
	
	var num = 1 + randi() % max_val
	solution = [num*solution_pre, num]
	
	options = []
	for i in range(0, 5):
		num = 1 + randi() % max_val
		options.append([options_pre[i]*num, num])


func generate():
	randomize()
	var n = randi() % 2
	
	if n == 0:
		generate_min()
	else:
		generate_max()

# val is an array of size 2
func display_option(val):
	return "%d : %d" % [val[0], val[1]]


func display_problem():
	if _type == "min":
		return "Find The Smallest Number"
	else:
		return "Find The Biggest Number"
