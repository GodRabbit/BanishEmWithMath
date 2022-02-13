extends puzzle_abstract


# copyright 2021,2022 Dor "GodRabbit" Shlush
# this file is part of "BanishEmWithMath"

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

class_name puzzle_fractions_division

var max_val

func _init(_max_val):
	max_val = _max_val

func generate():
	randomize()
	
	# divisor
	var a_n = 1 + randi() % max_val
	var a_d = 1 + randi() % max_val
	var f1 = Fraction.new(a_n, a_d)
	
	# dividened
	var b_n = 1 + randi() % max_val
	var b_d = 1 + randi() % max_val
	var f2 = Fraction.new(b_n, b_d)
	
	# if f is equal to 1, try again to generate something different (this will only slightly reduce chance of 1)
	if f2.is_one():
		b_n = 1 + randi() % max_val
		b_d = 1 + randi() % max_val
		f2 = Fraction.new(b_n, b_d)
	
	solution = f1.copy()
	solution.divide(f2)
	
	f1.simplify()
	f2.simplify()
	solution.simplify()
	data = {"x":f1, "y":f2}
	
	# TODO: this is not a good way to choose wrong solutions
	#  the correct answer will always be more complex
	# gets different fractions from the solution
	var pre_bank = solution.generate_different(max_val, true)
	
	var bank = []
	# remove duplicates:
	for f in pre_bank:
		# check if the bank already has f
		var found = false
		for b in bank:
			if b.equals(f):
				found = true
		if !found:
			bank.append(f)
	
	_pick_options_from_bank(bank)

func display_option(val):
	val.simplify()
	return str(val)

func display_problem():
	return str(data["x"]) + " : " + str(data["y"]) + " = ???"
