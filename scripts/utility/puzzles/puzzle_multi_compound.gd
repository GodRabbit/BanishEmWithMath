extends puzzle_abstract

# copyright 2021,2022 Dor "GodRabbit" Shlush
# this file is part of "BanishEmWithMath"

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

class_name puzzle_multi_compound

# In this puzzle the problem is a multiplication problem but all options
# are addition problems. The puzzle parameter is the max value of multiplicants
# its advisable to not go beyond 12. 
# example:
# problem: 4 X 5 = ???
# Solutions: 4 + 15, 13 + 12, 14 + 6, and so on..

const REAL_MIN_VAL = 2

var max_val = 12
var min_val = 2 # please don't choose nothing smaller

func _init(_min_val = 2, _max_val = 12):
	max_val = 12
	min_val = int(max(_min_val, REAL_MIN_VAL))

func generate():
	randomize()
	var x = min_val + randi() % (max_val - min_val +1)
	var y = 1 + randi() % (max_val - min_val + 1)
	data = {"x": x, "y": y}
	
	# if both x and y are 1, the split function cannot work
	if x == 1 and y == 1: 
		x = max_val
		y = max_val
	
	# proto-solution:
	var s = x*y
	
	# that actual solution is an array of 2 numbers, who's sum is s
	var arr = math_util.split(s)
	
	# choose a random element from arr:
	var index = randi() % arr.size()
	solution = arr[index]
	
	# now we need to choose the bank
	var bank = []
	
	var min_search = int(max(s - 20, 0)) # the minimum of the search in the bank; this way the value is never below zero
	for i in range(min_search, s + 20):
		if i != s:
			var barr = math_util.split(i)
			for j in barr:
				bank.append(j)
	_pick_options_from_bank(bank)

# returns a string that indicates how the problem will be presented
# in the displayer scene.
func display_problem() -> String:
	return "%d X %d = ???" % [data["x"], data["y"]]

# val is an array of size 2
func display_option(val):
	randomize()
	var num = randi() % 2
	if num == 0:
		return "%d + %d" % [val[0], val[1]]
	else:
		return "%d + %d" % [val[1], val[0]]
