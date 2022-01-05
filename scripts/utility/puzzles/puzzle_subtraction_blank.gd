extends puzzle_abstract

# copyright 2021,2022 Dor "GodRabbit" Shlush
# this file is part of "BanishEmWithMath"

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

class_name puzzle_subtraction_blank
# a puzzle class for subtraction problem in which either the subtracted or 
#  subtractee are blank.
# e.g. ____ - 7 = 8 (type 0)
# or: 7 - ____ = 5 (type 1)

var max_val
var min_val

func _init(_min_val, _max_val):
	min_val = _min_val
	max_val = _max_val

func generate():
	# first choose whether to generate type 0 or type 1 problem
	randomize()
	var num = randi() % 2
	if num == 0: # type 0 problems
		data["type"] = 0
		var x = min_val + randi() % (max_val - min_val + 1)
		var y = min_val + randi() % (max_val - min_val + 1)
		
		# the problem will be:
		# solution - x = y
		solution = x + y
		data["x"] = x
		data["y"] = y
		
		# choose wrong solutions:
		var bank = []
		var m = int(max(solution - 10, 0))
		for i in range(m, solution + 10):
			if i != solution:
				bank.append(i)
		
		_pick_options_from_bank(bank)
	else:
		data["type"] = 1
		# the problem will be x - solution = y
		# so first we will choose solution and y, and then: x = y+solution
		var y = min_val + randi() % (max_val - min_val + 1)
		solution = min_val + randi() % (max_val - min_val + 1)
		
		var x = y + solution
		data["x"] = x
		data["y"] = y
		
		# choose wrong solutions:
		var bank = []
		var m = int(max(solution - 10, 0))
		for i in range(m, solution + 10):
			if i != solution:
				bank.append(i)
		
		_pick_options_from_bank(bank)

func display_problem():
	if data["type"] == 0:
		return "____ - %d = %d" % [data["x"], data["y"]]
	else:
		return "%d - ____ = %d" % [data["x"], data["y"]]
