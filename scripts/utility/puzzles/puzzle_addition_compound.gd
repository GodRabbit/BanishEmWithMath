extends puzzle_abstract

# copyright 2021,2022 Dor "GodRabbit" Shlush
# this file is part of "BanishEmWithMath"

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

# a class that represents an addition problem whose answers are also 
# addition problems.
# for example: 
#Problem: 34+28
# Options: 31 + 27; 44 + 12; 31 + 31
# options and solution for this problem are arrays!


class_name puzzle_addition_compound

# min and max values for the solution:
var max_val
var min_val

func _init(_min_val = 10, _max_val = 100):
	min_val = _min_val
	max_val = _max_val

func generate():
	randomize()
	
	# first choose the target value:
	var x = min_val + randi() % (max_val - min_val + 1)
	
	# now we are gonna choose the problem:
	var arr = math_util.split(x)
	
	var index = randi() % arr.size()
	solution = arr[index]
	
	# erase the solution value, so the solution and problem are not the same:
	arr.remove(index)
	
	index = randi() % arr.size()
	data = {"problem": arr[index]}
	
	# now choose the bank:
	var bank = []
	
	# for every number that is not the target x,
	# add ALL the splits into the bank.
	# yes, some false options may add to the same wrong number
	# its not a problem :] 
	var m = int(max(x - 10, 0))
	for i in range(m, x + 10):
		if i != x:
			var barr = math_util.split(i)
			for y in barr:
				bank.append(y)
	_pick_options_from_bank(bank)


func display_problem() -> String:
	randomize()
	var num = randi() % 2
	if num == 0: # change the order of the addition sometimes:
		return "%d + %d = ???" % [data["problem"][0], data["problem"][1]]
	else:
		return "%d + %d = ???" % [data["problem"][1], data["problem"][0]]

# val is an array of size 2
func display_option(val):
	randomize()
	var num = randi() % 2
	if num == 0:
		return "%d + %d" % [val[0], val[1]]
	else:
		return "%d + %d" % [val[1], val[0]]
