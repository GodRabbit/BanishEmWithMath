extends puzzle_abstract

# copyright 2021,2022 Dor "GodRabbit" Shlush
# this file is part of "BanishEmWithMath"

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

class_name puzzle_division
# a class for division puzzles. the division is full with both quotient 
# and remainder. class variables are max value for quotient
# and max value for the divisor
# solution\options are arrays with 2 numbers the quotient and the remainder
# the solution\options will be displayed in the form q (r)

var max_quotient = 12
var max_divisor = 12

func _init(_max_divisor = 12, _max_quotient = 12):
	max_quotient = _max_quotient
	max_divisor = _max_divisor

func generate():
	# (x is the dividend and y is the divisor)
	# we first choose a divisor and solution (quotient and remainder)
	# and calculate the dividend from that
	randomize()
	var y = 2 + randi() % (max_divisor - 1)
	
	var q = 1 + randi() % (max_quotient - 1)
	
	# the remainder is always smaller than the divisor
	var r = randi() % y
	
	# calculate the dividend
	var x = y*q + r
	
	data = {"x":x, "y":y}
	
	solution = [q, r]
	
	# to choose the bank we loop through the options for a quotient
	# and the options for a remainder and add to the bank anything that is not 
	# the solution
	var bank = []
	var m = max(0, solution[0] - 5)
	for i in range(m, solution[0] + 5): # quotient
		for j in range(0, y): # remainder
			if i != solution[0] or j != solution [1]:
				var a = [i, j]
				bank.append(a)
	
	_pick_options_from_bank(bank)

func display_problem():
	return "%d : %d = ???" % [data["x"], data["y"]]

# val is an array of size 2
# display it as val[0] (val[1])
# as val[0] is the quotient and val[1] the remainder
func display_option(val):
	return "%d (%d)" % [val[0], val[1]]
