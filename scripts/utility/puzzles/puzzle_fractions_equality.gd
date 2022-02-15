extends puzzle_abstract


# copyright 2021,2022 Dor "GodRabbit" Shlush
# this file is part of "BanishEmWithMath"

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

# a puzzle for figuring out if 2 fractions are actually equal
#  those 2 fractions will generally not be simplified

class_name puzzle_fractions_equality

var frac_max_val
var gcd_max_val

func _init(_frac_max_val, _gcd_max_val):
	frac_max_val = _frac_max_val
	gcd_max_val = _gcd_max_val

func generate():
	randomize()
	
	# this makes sure that the denominator is different than the nominator
	var numbers0 = range(1, frac_max_val)
	var index0 = randi() % numbers0.size()
	
	var x_n = numbers0[index0]
	
	numbers0.remove(index0)
	
	index0 = randi() % numbers0.size()
	var x_d = numbers0[index0]
	
	var numbers = range(1, gcd_max_val + 1)
	
	# pick 2 numbers, g1 and g2, from numbers, 1 will be the multiplier for the problem
	# and the other for the solution
	var index = randi() % numbers.size()
	var g1 = numbers[index]
	numbers.remove(index)
	
	index = randi() % numbers.size()
	var g2 = numbers[index]
	numbers.remove(index)
	
	var x = Fraction.new(x_n*g1, x_d*g1)
	solution = Fraction.new(x_n*g2, x_d*g2)
	
	data = {"x":x}
	
	var pre_bank = solution.generate_different(frac_max_val, true)
	
	var bank = []
	# remove duplicates:
	for f in pre_bank:
		# check if the bank already has f
		var found = false
		for b in bank:
			if b.equals(f):
				found = true
		if !found:
			f.simplify()
			var g = 1 + randi() % (gcd_max_val - 1)
			f.expand(g)
			bank.append(f)
	
	_pick_options_from_bank(bank)


func display_problem():
	return "%s = ???" % str(data["x"])
