extends puzzle_abstract

# copyright 2021,2022 Dor "GodRabbit" Shlush
# this file is part of "BanishEmWithMath"

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

class_name puzzle_subtraction_compound


# An abstract class that creates puzzles in whish the options are subtracton
# (and\or addition) while the problem itself is subtraction.

# the min\max values for the target number for the question:
var min_val
var max_val

# will options be with addition as well as subtraction?
var allow_addition = false

func _init(_min_val = 5, _max_val = 20, _allow_addition = false):
	min_val = _min_val
	max_val = _max_val
	allow_addition = _allow_addition

# NOTICE: solution\options are arrays with 3 values, operator (add\subtract), 
# and the two numbers
func generate():
	randomize()
	# first choose the target value:
	var x = min_val + randi() % (max_val - min_val + 1)
	
	# now we are gonna choose the problem (the problem is always 
	# subtraction!)
	var arr = math_util.subtract_split(x, 2*x)
		
	# choose a random array out of the arrays:
	var index = randi() % arr.size()
	var problem = arr[index] # this is an array of 2 numbers whose difference is x
	data = {"problem":problem}
		
	arr.remove(index) # so we won't choose the same representation for the solution
	
	if allow_addition:
		# now its time to choose the solution. the solution can be either
		# addition or subtraction
		var solution_bank = []
		for a in arr:
			solution_bank.append(["-", a[0], a[1]])
		
		var arr_addition = math_util.split(x)
		
		for a in arr_addition:
			solution_bank.append(["+", a[0], a[1]])
		
		# choose a solution at random:
		index = randi() % solution_bank.size()
		solution = solution_bank[index]
		
		# now its time to do the same things for the wrong options:
		var bank = []
		var m = int(max(x - 10, 4))
		for y in range(m, x + 10):
			if y != x:
				# for subtraction:
				var arr_sub = math_util.subtract_split(y, 2*y)
				for a in arr_sub:
					bank.append(["-", a[0], a[1]])
				
				# for addition:
				var arr_add = math_util.split(y)
				for a in arr_add:
					bank.append(["+", a[0], a[1]])
		
		_pick_options_from_bank(bank)
	else:
		# now its time to choose the solution. solution can only be subtraction:
		var solution_bank = []
		for a in arr:
			solution_bank.append(["-", a[0], a[1]])
		
		# choose a solution at random:
		index = randi() % solution_bank.size()
		solution = solution_bank[index]
		
		# now its time to do the same things for the wrong options:
		var bank = []
		var m = int(max(x - 10, 4))
		for y in range(m, x + 10):
			if y != x:
				# for subtraction:
				var arr_sub = math_util.subtract_split(y, 2*y)
				for a in arr_sub:
					bank.append(["-", a[0], a[1]])
		
		_pick_options_from_bank(bank)

func display_problem():
	return "%d - %d = ???" % [data["problem"][0], data["problem"][1]]

func display_option(val):
	if val[0] == "+":
		randomize()
		var num = randi() % 2
		if num == 0:
			return "%d + %d" % [val[2], val[1]]
		else:
			return "%d + %d" % [val[1], val[2]]
	else:
		return "%d - %d" % [val[1], val[2]]
	return ""
