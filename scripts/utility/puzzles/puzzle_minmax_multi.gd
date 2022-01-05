extends puzzle_abstract

# copyright 2021,2022 Dor "GodRabbit" Shlush
# this file is part of "BanishEmWithMath"

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

class_name puzzle_minmax_multi
# a class for min\max problems with multiplication as the answer

var _type = "min"

var max_val = 10

func _init(_max_val = 10):
	max_val = _max_val

func generate_min():
	_type = "min"
	
	var pairs = math_util.split_divisors(max_val)
	
	var keys = pairs.keys().duplicate()
	keys.sort()
	
	# these are indexes fo the keys array.
	#  its using the technique in pick_min_number to choose a max number
	#  in a balanced way
	var indexes = math_util.pick_min_number(keys.size() - 1)
	
	var solution_multiply = keys[indexes[0]] # result of the multiplication of solution
	
	# pick a random pair whose multiplication is solution_multiply, for the solution
	randomize()
	var j = randi() % pairs[solution_multiply].size()
	
	solution = pairs[solution_multiply][j]
	
	# now loop through the rest of the indexes to get the options
	options = []
	for i in indexes[1]:
		var multi = keys[i]
		j = randi() % pairs[multi].size()
		options.append(pairs[multi][j])


func generate_max():
	_type = "max"
	
	var pairs = math_util.split_divisors(max_val)
	
	var keys = pairs.keys().duplicate()
	keys.sort()
	
	# these are indexes fo the keys array.
	#  its using the technique in pick_min_number to choose a max number
	#  in a balanced way
	var indexes = math_util.pick_max_number(keys.size() - 1)
	
	var solution_multiply = keys[indexes[0]] # result of the multiplication of solution
	
	# pick a random pair whose multiplication is solution_multiply, for the solution
	randomize()
	var j = randi() % pairs[solution_multiply].size()
	
	solution = pairs[solution_multiply][j]
	
	# now loop through the rest of the indexes to get the options
	options = []
	for i in indexes[1]:
		var multi = keys[i]
		j = randi() % pairs[multi].size()
		options.append(pairs[multi][j])

func generate():
	randomize()
	var n = randi() % 2
	
	if n == 0:
		generate_min()
	else:
		generate_max()

func display_problem():
	if _type == "min":
		return "Find The Smallest Number"
	else:
		return "Find The Biggest Number"

# val is an array of size 2
func display_option(val):
	randomize()
	var num = randi() % 2
	if num == 0:
		return "%dX%d" % [val[0], val[1]]
	else:
		return "%dX%d" % [val[1], val[0]]
