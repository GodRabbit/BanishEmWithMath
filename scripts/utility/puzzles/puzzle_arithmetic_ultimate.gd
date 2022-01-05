extends puzzle_abstract

# copyright 2021,2022 Dor "GodRabbit" Shlush
# this file is part of "BanishEmWithMath"

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

class_name puzzle_arithmetic_ultimate

# TODO: finish..? is this even possible?
# A class for creating a general arithmetic problem, with n numbers
# and n-1 operations between them. The result is alwyas an integer.
# Each integer is always between 0 and max_val.
# for simplicity case, division is not allowed, only +, -, *

var max_val = 12

func _init(_max_val = 12):
	pass

# a recursive function to generate a problem with n numbers
# the input is an array <ops> of n-1 operations
# the result is a dictionary of the form
# result = {"numbers":[<num1>, <num2>, <num3>,...], "operations":[<op1>,...], "solution":<number>}
func _create_problem(ops):
	if ops.size() == 0:
		randomize()
		var num = randi() % max_val
		return {"numbers":[num], "operations":[], "solution":num}
	elif ops.size() == 1:
		var result = {}
		randomize()
		var n1 = randi() % max_val
		var n2 = randi() % max_val
		
		result["operations"] = ops[0]
		
		match ops[0]:
			"+":
				result["solution"] = n1+n2
				result["numbers"]= [n1, n2]
			"-":
				result["solution"] = n1-n2
				result["numbers"]= [n1, n2]
				
			
	# search for a plus or a minus, and split the 2 arrays that creates for the recursion
	var found = false
	for i in range(0, ops.size()):
		if (ops[i] == "+" or ops[i] == "-") and !found:
			found = true
			var index = i
			var bot = ops.slice(0, index - 1)
			var top = ops.slice(index + 1, ops.size() - 1)
			var result_bot = _create_problem(bot)
			var result_top = _create_problem(top)
			
			var s = math_util.calculate(ops[index], result_bot["solution"], result_top["solution"])
			
			break
		
	

func generate():
	pass
