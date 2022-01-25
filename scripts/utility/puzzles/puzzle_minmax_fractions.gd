extends puzzle_abstract


# copyright 2021,2022 Dor "GodRabbit" Shlush
# this file is part of "BanishEmWithMath"

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

class_name puzzle_minmax_fractions

var _type = "min"
var max_val = 10 # try not to pick anything larger than 10, as this is really slow
var allow_whole = false
var cutoff = 2.0 # a float that all the list is smaller then; use 1.0 when you want the questions to be really tough

# a list of all the unique fractions between 1/max_val to max_val
# this list is ordered!
var _fraction_list = []

func _init(_max_val = 10, _allow_whole = false, _cutoff = 2.0):
	if _max_val < 3: # max_val below 3 will throw exception
		max_val = 3
	else:
		max_val = _max_val
	allow_whole = _allow_whole
	cutoff = _cutoff
	_generate_fraction_list()

# attempt to add a fraction <f> to the list.
# this list is ordred, so f must be inserted accordingly
func _add_to_fraction_list(f : Fraction):
	if !allow_whole && f.is_whole():
		return
	if f.to_float() > cutoff:
		return
	if _fraction_list.size() <= 0:
		_fraction_list.append(f)
	else:
		var found = false # have we found an element bigger than f?
		for i in range(0, _fraction_list.size()):
			var g = _fraction_list[i]
			var comparison = g.compare(f)
			if comparison == 0: # g == f
				return
			elif comparison > 0: # g > f
				_fraction_list.insert(i, f)
				found = true
				return
		
		if !found:
			_fraction_list.append(f)

# creates an ordered array of unique fractions
func _generate_fraction_list():
	for i in range(1, max_val + 1):
		for j in range(1, max_val + 1):
			var f = Fraction.new(i, j)
			f.simplify()
			_add_to_fraction_list(f)

func _get_fraction_list():
	return _fraction_list

func generate_min():
	_type = "min"
	
	# since _fractionlist is ordered we can use the pick_min on the size of the array
	# to get the indexes of the solution and the options
	var result_index = math_util.pick_min_number(_fraction_list.size() - 1)
	
	var solution_index = result_index[0]
	
	var options_index = result_index[1]
	
	solution = _fraction_list[solution_index]
	
	options = []
	for i in options_index:
		var f = _fraction_list[i]
		options.append(f)

func generate_max():
	_type = "max"
	
	# since _fractionlist is ordered we can use the pick_min on the size of the array
	# to get the indexes of the solution and the options
	var result_index = math_util.pick_max_number(_fraction_list.size() - 1)
	
	var solution_index = result_index[0]
	
	var options_index = result_index[1]
	
	solution = _fraction_list[solution_index]
	
	options = []
	for i in options_index:
		var f = _fraction_list[i]
		options.append(f)

func generate():
	randomize()
	var n = randi() % 2
	
	if n == 0:
		generate_min()
	else:
		generate_max()

func display_problem():
	if _type == "min":
		return "Find The Smallest Number"
	else:
		return "Find The Biggest Number"
