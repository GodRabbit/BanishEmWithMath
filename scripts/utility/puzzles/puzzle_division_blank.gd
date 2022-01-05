extends puzzle_abstract

# copyright 2021,2022 Dor "GodRabbit" Shlush
# this file is part of "BanishEmWithMath"

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

class_name puzzle_division_blank
# a class for puzzles with division blankg, either the divisor or divident.
#  this class has 2 generates function that are chosen randomly, based on where
#  the blank is.


const TYPES = 2
var type = 0

var max_val
var min_val

func _init(_min_val = 1, _max_val = 10):
	min_val = _min_val
	max_val = _max_val

func generate_0():
	# ____ : x = y
	type = 0
	randomize()
	var x = min_val + randi() % (max_val - min_val + 1)
	var y = min_val + randi() % (max_val - min_val + 1)
	solution = x*y
	data = {"x":x, "y":y}

func generate_1():
	# x : ____ = y
	type = 1
	randomize()
	solution = min_val + randi() % (max_val - min_val + 1)
	var y = min_val + randi() % (max_val - min_val + 1)
	var x = solution*y
	data = {"x":x, "y":y}

func generate():
	randomize()
	type = randi() % TYPES
	
	call("generate_"+str(type))
	
	# pick bank:
	var bank = []
	var m = int(max(solution - 10, 0))
	for i in range(m, solution + 10):
		if i != solution:
			bank.append(i)
	_pick_options_from_bank(bank)

func display_problem():
	match type:
		0:
			return "____ : %d = %d" % [data["x"], data["y"]]
		1:
			return "%d : ____ = %d" % [data["x"], data["y"]]
