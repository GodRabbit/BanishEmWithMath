extends Reference

# copyright 2021,2022 Dor "GodRabbit" Shlush
# this file is part of "BanishEmWithMath"

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

class_name puzzle_abstract

# an abstract class that represents a general problem
# the data is the actual problem and the solution is the solution
# the puzzle create 5 wrong answers, so the puzzle will be choice-question.

# the data needed to create the puzzle. a dictionary
var data = {}

# the solution to the problem
var solution = 0

# the other incorrect options in the puzzle
var options = []

# generates a problem and solution
func generate():
	pass

func get_data():
	return data

func get_solution():
	return solution

func get_options():
	return options

# check if the element <e> is in <arr>
# if not, it add it.
# if positive_only is true - it only add e if e is a positive int.
# you cannot add an element that is equal to solution
func _check_and_add(arr : Array, e : int, positive_only = true):
	if e == solution:
		return
	if not e in arr:
		if positive_only and e > 0:
			arr.append(e)
		elif not positive_only:
			arr.append(e)

func _pick_options_from_bank(bank):
	# clean options first:
	options = []
	# choose a random 5 wrong answers from the bank
	
	randomize()
	for i in range(0, 5):
		# choose a random index out of bank 
		var index = randi() % bank.size()
		
		# add the element into options:
		options.append(bank[index])
		
		# remove the element so we wont choose it again
		bank.remove(index)

# used to fix banks that are too small to manage, by inserting random garbage
# all the garbage is numbers, so note on using this on m,ore complicated puzzles
func _fix_faulty_bank(bank : Array, a, b):
	randomize()
	for i in range(0, 10):
		var r = randi() % a
		_check_and_add(bank, (a*i + b*r))
	for i in bank:
		var r = randi() % a
		_check_and_add(bank, (a*i + b*r))

func _print_puzzle():
	Log.log_print(str(data))
	Log.log_print(str(options))
	Log.log_print(str(solution))

# returns a string that indicates how the problem will be presented
# in the displayer scene.
func display_problem() -> String:
	return ""

# returns a dictionary that represents how to display the problem in
# an expression_display control.
func get_display_data():
	return {}

# returns a class name of the expression_displayer that corresponds to this
#  problem. default is the string expresseion (only a string and nothing more)
func get_display_class_name():
	return "expression_string"

# take an option or solution as an argument and turn them
# into a string. Most of the time its just a conversion
# but you can override it to create a complex mechanism
func display_option(val) -> String:
	return str(val)
