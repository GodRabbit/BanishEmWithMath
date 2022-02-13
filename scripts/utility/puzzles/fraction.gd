extends Reference

# copyright 2021,2022 Dor "GodRabbit" Shlush
# this file is part of "BanishEmWithMath"

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

class_name Fraction
# a class that represents a simple fraction

var numer = 0
var denom = 1

func _init(_numer = 0, _denom = 1):
	numer = _numer
	denom = _denom

func from_array(a : Array):
	numer = a[0]
	denom = a[1]

# simplify this fraction
func simplify():
	if numer == denom:
		numer = 1
		denom = 1
		return
	var g = math_util.gcd(numer, denom)
	while g > 1:
		numer = int(numer/g)
		denom = int(denom/g)
		g = math_util.gcd(numer, denom)
	_normalize()

func equals(a : Fraction):
	if numer*a.denom == denom*a.numer:
		return true
	else:
		return false

func compare(a : Fraction):
	if numer*a.denom > denom*a.numer:
		return 1
	elif numer*a.denom < denom*a.numer:
		return -1
	else:
		return 0

# makes sure that negative fraction always has minus sign on the numerator
# call this function after every operation
func _normalize():
	if numer < 0 && denom < 0:
		numer = -numer
		denom = -denom
	elif numer > 0 && denom < 0:
		numer = -numer
		denom = -denom

func add(a : Fraction):
	var x = numer*a.denom + denom*a.numer
	var y = a.denom*denom
	numer = x
	denom = y
	simplify()

func subtract(a : Fraction):
	var x = numer*a.denom - denom*a.numer
	var y = a.denom*denom
	numer = x
	denom = y
	simplify()

func multiply(a : Fraction):
	var x = numer*a.numer
	var y = a.denom*denom
	numer = x
	denom = y
	simplify()

func divide(a : Fraction):
	var x = numer*a.denom
	var y = a.numer*denom
	numer = x
	denom = y
	simplify()

func expand(n : int):
	numer = n*numer
	denom = n*denom

# returns a copy of this fraction
func copy():
	var Self = load("res://scripts/utility/puzzles/fraction.gd")
	return Self.new(numer, denom)

func _to_string():
	if denom == 1 || numer == 0:
		return str(numer)
	if numer >= 0:
		return "%d/%d" % [numer, denom]
	else:
		return "(%d/%d)" % [numer, denom]

func is_whole():
	return numer % denom == 0

func is_one():
	return numer == denom

func to_float():
	return float(numer)/float(denom)

# creates an array of fractions (not necesserly simplified) that are different
# from this fraction
#  <max_val> is how large the numerator and denomartors can be.
#  O(max_val^2)
func generate_different(max_val, is_simplified = false):
	var Self = load("res://scripts/utility/puzzles/fraction.gd")
	var result = []
	for i in range(1, max_val + 1):
		for j in range(1, max_val + 1):
			var f = Self.new(i, j)
			if !equals(f):
				if is_simplified:
					f.simplify()
				result.append(f)
	return result
