extends puzzle_abstract

# copyright 2021,2022 Dor "GodRabbit" Shlush
# this file is part of "BanishEmWithMath"

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

class_name puzzle_minmax_basic
# a class for puzzle min max. The player need to choose the biggest\smallest
#  number.
# There are 2 generate functions one for min and one for max. The main generate
#  picks one of them at random.


# "min" for minimum problem. "max" is for maximum problems.
var _type = "min"

var max_val = 100

# whats the smallest max_val possible.
const MIN_MAX_VAL = 6

func _init(_max_val = 100):
	max_val = _max_val

# using the pick_number functions create more diverse and interesting problems
func generate_min():
	_type = "min"
	var result = math_util.pick_min_number(max_val)
	solution = result[0]
	options = result[1]


func generate_max():
	_type = "max"
	var result = math_util.pick_max_number(max_val)
	solution = result[0]
	options = result[1]

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
