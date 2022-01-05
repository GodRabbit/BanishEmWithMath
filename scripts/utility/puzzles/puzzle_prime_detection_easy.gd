extends "res://scripts/utility/puzzles/puzzle_abstract.gd"

# copyright 2021,2022 Dor "GodRabbit" Shlush
# this file is part of "BanishEmWithMath"

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

# DEPRECATED
#class_name puzzle_prime_detection_easy

# in this problem the six options are six numbers only one of them is 
# prime. in this easy version the numbers are below 100, and the composite
# numbers can be even


func generate():
	# choose a random prime number for the solution
	randomize()
	var index = randi() % math_util.PRIMES.size()
	solution = math_util.PRIMES[index]
	
	# the bank is every composite number between 4 - 100
	var bank = []
	for i in range(1, 101):
		if !(i in math_util.PRIMES):
			bank.append(i)
	
	_pick_options_from_bank(bank)

func display_problem():
	return "Find the prime number!"
