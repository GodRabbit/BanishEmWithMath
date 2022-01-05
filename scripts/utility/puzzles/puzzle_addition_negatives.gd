extends puzzle_abstract

# copyright 2021,2022 Dor "GodRabbit" Shlush
# this file is part of "BanishEmWithMath"

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

class_name puzzle_addition_negatives

# puzzle of both addition in subtraction, with negative numbers

var max_val = 100

func _init(_max_val = 100):
	max_val = _max_val

func generate():
	randomize()
	var x = randi() % max_val
	var y = randi() % max_val
	
	var b1 = randi() % 2
	var b2 = randi() % 2
	var b3 = randi() % 2
	
	if b1 == 0:
		x  = -x
	if b2 == 0:
		y = -y
	
	data = {"x":x, "y":y}
	
	if b3 == 0:
		solution = x + y
		data["operation"] = "+"
	else:
		solution = x - y
		data["operation"] = "-"
	
	var bank = []
	for i in range(solution - 10, solution + 11):
		if i != solution:
			bank.append(i)
	
	_pick_options_from_bank(bank)

func display_problem():
	# when displaying a problem, if a number is negative put it in 
	# paranthesis
	var str_x = str(data["x"])
	var str_y = str(data["y"])
	if data["x"] < 0:
		str_x = "(%d)" % data["x"]
	if data["y"] < 0:
		str_y = "(%d)" % data["y"]
	return "%s %s %s = ???" % [str_x, data["operation"] ,str_y]
