extends puzzle_abstract

# copyright 2021,2022 Dor "GodRabbit" Shlush
# this file is part of "BanishEmWithMath"

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

class_name puzzle_arithmetic_sequence
# a class that creates arithemetic sequences. The objective is to find the next
# number in the progression.
# we use the standrt a0, a1, a2, a3. The player will need to find a3.
# general formula an=a0+nd

# min and max value for the first element in the sequence
var a0_min
var a0_max

# min and max vals for the difference <d>
var d_min
var d_max

# forces the elements in the progression to be positive
# if its possible
var force_positive = true

const DEFAULT = 10

func _init(_a0_min, _a0_max, _d_min, _d_max, _force_positive):
	a0_min = _a0_min
	a0_max = _a0_max
	d_min = _d_min
	d_max = _d_max
	force_positive = _force_positive

func generate():
	randomize()
	if force_positive:
		# first check if the diference is positive or negative
		var d = d_min + randi() % (d_max - d_min + 1)
		var a0_min_normalized = int(max(a0_min, 0))
		var a0_max_normalized = a0_max
		if d < 0:
			# if the difference is negative, we need to force a0 to be 
			# big enough so that the 3rd element is positive
			a0_min_normalized = int(max(a0_min, -3*d))
			
			# now check that a0_max is still bigger than a0_min_normalized
			# if not, normalize it.
			if a0_max <= a0_min_normalized:
				 a0_max_normalized = a0_min_normalized + DEFAULT
		
		# now we can pick a0
		var a0 = a0_min_normalized + randi() % (a0_max_normalized - a0_min_normalized + 1)
		
		solution = a0 + 3*d
		data = {"a0": a0, "d":d}
		
		# choose bank
		var bank = []
		var m = int(max(solution - 10, 0))
		for i in range(m, solution + 10):
			if i != solution:
				bank.append(i)
		
		# choose a random 5 wrong answers from the bank
		_pick_options_from_bank(bank)
	else:
		var d = d_min + randi() % (d_max - d_min + 1)
		var a0 = a0_min + randi() % (a0_max - a0_min + 1)
		
		solution = a0 + 3*d
		data = {"a0": a0, "d":d}
		
		# choose bank
		var bank = []
		for i in range(solution - 20, solution + 20):
			if i != solution:
				bank.append(i)
		
		_pick_options_from_bank(bank)

func display_problem() -> String:
	var a0 = data["a0"]
	var d = data["d"]
	return "%d, %d, %d, ???" % [a0, a0 + d, a0 + 2*d]
