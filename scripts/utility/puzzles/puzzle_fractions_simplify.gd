extends puzzle_abstract

# copyright 2021,2022 Dor "GodRabbit" Shlush
# this file is part of "BanishEmWithMath"

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

class_name puzzle_fractions_simplify
# a puzzle for simplifying fractions

var frac_max_val
var gcd_max_val

func _init(_frac_max_val, _gcd_max_val):
	frac_max_val = _frac_max_val
	gcd_max_val = _gcd_max_val

func generate():
	randomize()
	
	var x_n = 1 + randi() % frac_max_val
	var x_d = 1 + randi() % frac_max_val
	
	var g = 2 + randi() % (gcd_max_val - 1)
	
	var x = Fraction.new(x_n*g, x_d*g)
	
	data = {"x":x}
	solution = x.copy()
	solution.simplify()
	
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
			bank.append(f)
	
	_pick_options_from_bank(bank)

func display_problem():
	return "Simplify %s" % str(data["x"])
