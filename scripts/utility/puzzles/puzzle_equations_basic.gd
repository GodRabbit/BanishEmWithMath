extends puzzle_abstract


# copyright 2021,2022 Dor "GodRabbit" Shlush
# this file is part of "BanishEmWithMath"

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

class_name puzzle_equations_basic
# a class for basic equations of the form ax + b = c
# where a = +- 1, 2
# and b,c < max_val

var max_val

func _init(_val):
	max_val = _val

func generate():
	randomize()
	
	# pick a 
	var a = 1
	var n = randi() % 2
	if n == 0: # a is positive:
		a = 1 + randi() % 2
	else:
		a = -(1 + randi() % 2)
	var b = -max_val + randi() % (2*max_val + 1)
	var c = -max_val + randi() % (2*max_val + 1)
	
	if a == 1 and b == 0:
		var num = randi() % 2
		if num == 1:
			b = 1 + randi() % (max_val + 1)
		else:
			b = -(1 + randi() % (max_val + 1))
	
	solution = float(c - b)/float(a)
	
	data = {"a": a, "b": b, "c":c}
	
	var bank = []
	for i in range(-5, 6):
		var j = solution + 0.5*i
		if i != 0:
			bank.append(j)
	
	_pick_options_from_bank(bank)

func display_problem():
	var a = data["a"]
	var b = data["b"]
	var c = data["c"]
	var s = ""
	if b > 0:
		if a == 1:
			s = "x + %d = %d"
			return s % [b, c]
		elif a == -1:
			s = "-x + %d = %d"
			return s % [b, c]
		else:
			s = "%dx + %d = %d"
			return s % [a, b, c]
	elif b < 0:
		if a == 1:
			s = "x - %d = %d"
			return s % [-b, c]
		elif a == -1:
			s = "-x - %d = %d"
			return s % [-b, c]
		else:
			s = "%dx - %d = %d"
			return s % [a, -b, c]
	else:
		if a == 1:
			s = "x = %d"
			return s % [c]
		elif a == -1:
			s = "-x = %d"
			return s % [c]
		else:
			s = "%dx = %d"
			return s % [a, c]

# sometimes the godot float to string shows -0
# so this is a quick fix
func display_option(val):
	if val == 0.0:
		return "x = 0"
	else:
		return "x = %s" % str(val)
