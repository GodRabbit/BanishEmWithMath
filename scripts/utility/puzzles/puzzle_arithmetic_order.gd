extends puzzle_abstract

# copyright 2021,2022 Dor "GodRabbit" Shlush
# this file is part of "BanishEmWithMath"

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

class_name puzzle_arithmetic_order
# an abstract class for puzzles of arithemetic order with multiplication, 
#  addition and subtraction.
# There are several templates for this puzzles:
#    0. x+\-y+\-z+\-w
#    1. (x+\-y)*(z+\-w)
#    2. x*(y+\-z)+\-w
#    3. (x+\-y)*z+\-w
#    4. x*(y+\-z+\-w)
#    5. x*y+\-z*w
#    6. x*(y+\-z)*w
#    7. x*y*(w+\-z)
#    8. x+\-y+\-z*w
# each template has its own generate, that generates the data accordingly.
# the specific generate functions don't generate the bank and wrong options. 
# TODO: add support for negative numbers? 

const TEMPLATES = 9

var max_val = 10
var min_val = 0

var _template = 0

func _init(_min_val = 0, _max_val = 10):
	min_val = _min_val
	max_val = _max_val

func generate_0():
	_template = 0
	# x+\-y+\-z+\-w
	randomize()
	var mi = int(max(2, min_val))
	var ma = 4*max_val
	solution = mi + randi() % (ma - mi + 1)
	var arr = math_util.ultimate_split_into(solution, 4)
	data = {"arr":arr}

func generate_1():
	_template = 1
	# (x+\-y)*(z+\-w)
	randomize()
	var mi = int(max(2, min_val))
	var ma = max_val
	
	var num1 = mi + randi() % (ma - mi + 1)
	var num2 = mi + randi() % (ma - mi + 1)
	
	var arr1 = math_util.ultimate_split_into(num1, 2)
	var arr2 = math_util.ultimate_split_into(num2, 2)
	
	solution = num1*num2
	data = {"arr1":arr1, "arr2":arr2}

func generate_2():
	_template = 2
	# x*(y+\-z)+\-w
	randomize()
	var x = min_val + randi() % (max_val - min_val + 1)
	
	var mi = int(max(2, min_val))
	var yz = mi + randi() % (max_val - mi + 1)
	
	var arr1 = math_util.ultimate_split_into(yz, 2)
	
	var w = 0
	var n = randi() % 2
	if n == 0: # the op before w is addition
		w = min_val + randi() % (max_val - min_val + 1)
	else: # the op before w is subtraction
		var ma = int(min(x*yz, max_val))
		mi = int(min(min_val, 2))
		w = mi + randi() % (ma - mi + 1)
		w = -w
	solution = x*yz + w
	data = {"x":x, "arr":arr1, "w":w}

func generate_3():
	# (x+\-y)*z+\-w
	#  same as generate_2, just with different order display!
	generate_2()
	_template = 3 # template must override the generate_2

func generate_4():
	_template = 4
	# x*(y+\-z+\-w)
	randomize()
	var mi = int(max(2, min_val))
	var ma = 2*max_val
	
	var yzw = mi + randi() % (ma - mi + 1)
	var arr = math_util.ultimate_split_into(yzw, 3)
	var x = min_val + randi() % (max_val - min_val + 1)
	
	data = {"x":x, "arr":arr}
	solution = x*yzw

func generate_5():
	_template = 5
	# x*y+z*w
	randomize()
	var x = min_val + randi() % (max_val - min_val + 1)
	var y = min_val + randi() % (max_val - min_val + 1)
	var z = min_val + randi() % (max_val - min_val + 1)
	var w = min_val + randi() % (max_val - min_val + 1)
	
	var n = randi() % 2
	if z*w <= x*y && n == 0:
		data ={"op":"-", "arr":[x,y,z,w]}
		solution = x*y-z*w
	elif z*w > x*y || n == 1:
		data ={"op":"+", "arr":[x,y,z,w]}
		solution = x*y+z*w

func generate_6():
	_template = 6
	 # x*(y+\-z)*w
	randomize()
	var x = min_val + randi() % (max_val - min_val + 1)
	var w = min_val + randi() % (max_val - min_val + 1)
	
	var mi = int(max(2, min_val))
	var ma = max_val
	var yz = mi + randi() % (ma - mi + 1)
	
	var arr = math_util.ultimate_split_into(yz, 2)
	solution = x*yz*w
	data = {"x":x, "arr":arr, "w":w}

func generate_7():
	# x*y*(w+\-z)
	# same generate as 6
	generate_6()
	_template = 7 # template must override the generate_6

func generate_8():
	# x+\-y+\-z*w
	_template = 8
	randomize()
	var mi = int(max(2, min_val))
	var ma = 2*max_val
	var xy = mi + randi() % (ma - mi + 1)
	var arr = math_util.ultimate_split_into(xy, 2)
	
	var z = min_val + randi() % (max_val - min_val + 1)
	var w = min_val + randi() % (max_val - min_val + 1)
	
	var n = randi() % 2
	if z*w <= xy && n==0:
		data = {"op":"-", "arr":arr, "z":z, "w":w}
		solution = xy - z*w
	else:
		data = {"op":"+", "arr":arr, "z":z, "w":w}
		solution = xy + z*w

func generate():
	# pick a random template and generate it:
	randomize()
	_template = randi() % TEMPLATES
	
	call("generate_"+str(_template))
	
	# pick bank:
	var bank = []
	var m = int(max(solution - 10, 0))
	for i in range(m, solution + 10):
		if i != solution:
			bank.append(i)
	_pick_options_from_bank(bank)

# takes arr of numbers and create a string of addition\subtraction
# between them.
#  e.g. arr = [5, -3, 4] -> "5 - 3 + 4"
func _chain_add(arr):
	var s = str(arr[0])
	for i in range(1, arr.size()):
		if arr[i] >= 0:
			s = s + (" + %d" % arr[i])
		else:
			s = s + (" - %d" % -arr[i])
	return s

func display_problem():
	var finish = "= ???"
	match _template:
		0:
			return _chain_add(data["arr"]) + finish
		1:
			var s1 = _chain_add(data["arr1"])
			var s2 = _chain_add(data["arr2"])
			var s = "("+s1+")X("+s2+")"
			return s + finish
		2:
			var s = "%dX" % data["x"]
			var s2 = _chain_add(data["arr"])
			s += "("+s2+")"
			var w = data["w"]
			if w >= 0:
				s+= (" + %d" % w)
			else:
				s+= (" - %d" % -w)
			return s + finish
		3:
			var s = ""
			var s2 = _chain_add(data["arr"])
			s += "("+s2+")"
			s+= ("X%d" % data["x"])
			var w = data["w"]
			if w >= 0:
				s+= (" + %d" % w)
			else:
				s+= (" - %d" % -w)
			return s + finish
		4:
			var s1 = _chain_add(data["arr"])
			var s = "%dX(%s)" % [data["x"], s1]
			return s + finish
		5:
			var s  = "%dX%d %s %dX%d" % [data["arr"][0], data["arr"][1],data["op"], data["arr"][2], data["arr"][3]]
			return s + finish
		6:
			var s1 = _chain_add(data["arr"])
			var s = "%dX(%s)X%d" % [data["x"], s1, data["w"]]
			return s + finish
		7:
			var s1 = _chain_add(data["arr"])
			var s = "%dX%dX(%s)" % [data["x"], data["w"], s1]
			return s + finish
		8:
			var s1 = _chain_add(data["arr"])
			var s =  "%s %s %dX%d" % [s1, data["op"], data["z"], data["w"]]
			return s + finish
