extends Node2D

# copyright 2021,2022 Dor "GodRabbit" Shlush
# this file is part of "BanishEmWithMath"

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.


# Called when the node enters the scene tree for the first time.
func _ready():
	test_equations_basic()


func test_split_into():
	for i in range(0, 20):
		var arr = math_util.split_into(i, 4)
		print(str(i))
		print(arr)
		print("_______________________")

func test_ultimate_split():
	for i in range(2, 50):
		var arr = math_util.ultimate_split_into(i, 4)
		print(str(i))
		print(arr)
		print("___________________")

func test_generate(num, amount):
	for i in range(0, amount):
		var p = puzzle_division_blank.new(1,10)
		p.generate()
		print(p.display_problem())
		print(p.solution)
		print("_______________")

func test_fractions():
	for i in range(1, 21):
		for j in range(1, 21):
			var f1 = Fraction.new(i, j)
			var f2 = f1.copy()
			f2.simplify()
			print(str(f1) + " -> " + str(f2))

func test_fractions2():
	var f = Fraction.new(1, 2)
	print(f.generate_different(5, true))

func test_minmax_puzzles():
	for i in range(0, 20):
		var p = puzzle_minmax_basic.new(100)
		p.generate()
		print(p.display_problem())
		print(p.options)
		print(p.solution)
		print("_______________")

func test_picking_minmax():
	print("___MAX___")
	for i in range(0, 10):
		var a = math_util.pick_max_number(100)
		print(a)
		print("_______________")
	print("___MIN___")
	for i in range(0, 10):
		var a = math_util.pick_min_number(100)
		print(a)
		print("_______________")

func test_minmax_puzzles_addition():
	for i in range(0, 20):
		var p = puzzle_minmax_addition.new(100)
		p.generate()
		print(p.display_problem())
		print(p.options)
		print(p.solution)
		print("_______________")

func test_minmax_puzzles_subtraction():
	for i in range(0, 20):
		var p = puzzle_minmax_subtraction.new(100)
		p.generate()
		print(p.display_problem())
		print(p.options)
		print(p.solution)
		print("_______________")

func test_split_divisors():
	print(math_util.split_divisors(10))
	print("____________________")

func test_minmax_generate_multi():
	for i in range(0, 20):
		var p = puzzle_minmax_multi.new()
		p.generate_max()
		print(p.display_problem())
		print(p.options)
		print(p.solution)
		print("_________________")

func test_minmax_generate_division():
	for i in range(0, 20):
		var p = puzzle_minmax_division.new()
		p.generate_max()
		print(p.display_problem())
		print(p.options)
		print(p.solution)
		print("_________________")

func test_puzzle_powers_two():
	for i in range(0, 20):
		var p = puzzle_powers_two.new()
		p.generate()
		print(p.display_problem())
		print(p.options)
		print(p.solution)
		print("_______________")

func test_balance_tester_function(item_ids):
	Log.log_print(str(items_data.get_average_gems(item_ids)))

func test_time_functions(ms):
	var d = math_util.ms_to_time_dictionary(ms)
	print(d)

func test_hs_data():
	randomize()
	for i in range(0, 30):
		var h = hs_entry.new("zone1", "NORMAL", randi() % 30000, 4, OS.get_datetime())
		hs_data.add_score(h)
	
	hs_data.log_print_hs("zone1")

func test_simplification():
	var f = Fraction.new(3, 3)
	f.simplify()
	Log.log_print(str(f))

func test_minmax_fractions():
	for i in range(0, 10):
		var p = puzzle_minmax_fractions.new(15, false, 1.0)
		p.generate()
		print(p.options)
		print(p.solution)
		print("___________________")

func test_fractions_mutiply():
	for i in range(0, 20):
		var p = puzzle_fractions_multi.new(10)
		p.generate()
		print(p.display_problem())
		print(p.options)
		print(p.solution)
		print("___________________")

func test_fractions_division():
	for i in range(0, 20):
		var p = puzzle_fractions_division.new(10)
		p.generate()
		print(p.display_problem())
		print(p.options)
		print(p.solution)
		print("___________________")

func test_percentages_to_fractions():
	for i in range(0, 20):
		var p = puzzle_percentages_to_fractions.new()
		p.generate()
		print(p.display_problem())
		print(p.options)
		print(p.solution)
		print("___________________")

func test_decimals_to_simple():
	for i in range(0, 20):
		var p = puzzle_fractions_decimals_to_simple.new()
		p.generate()
		print(p.display_problem())
		print(p.options)
		print(p.solution)
		print("___________________")

func test_fractions_decimals_addition():
	for i in range(0, 20):
		var p = puzzle_fractions_decimals_addition.new()
		p.generate()
		print(p.display_problem())
		print(p.options)
		print(p.solution)
		print("___________________")

func test_fractions_decimals_multi():
	for i in range(0, 20):
		var p = puzzle_fractions_decimals_multi.new()
		p.generate()
		print(p.display_problem())
		print(p.options)
		print(p.solution)
		print("___________________")

func test_fractions_decimals_division():
	for i in range(0, 20):
		var p = puzzle_fractions_decimals_division.new()
		p.generate()
		print(p.display_problem())
		print(p.options)
		print(p.solution)
		print("___________________")

func test_pick_prime():
	for i in range(0, 10):
		Log.log_print(str(math_util.pick_prime(15, 2)))
		print("________________________")

func test_fractions_equality():
	for i in range(0, 20):
		var p = puzzle_fractions_equality.new(10, 10)
		p.generate()
		print(p.display_problem())
		print(p.options)
		print(p.solution)
		print("___________________")

func test_fractions_simple_to_decimals():
	for i in range(0, 20):
		var p = puzzle_fractions_simple_to_decimals.new()
		p.generate()
		print(p.display_problem())
		print(p.options)
		print(p.solution)
		print("___________________")

func test_common_divisor():
	for i in range(0, 20):
		var p = puzzle_common_divisor.new(15)
		p.generate()
		print(p.display_problem())
		print(p.options)
		print(p.solution)
		print("___________________")

func test_equations_basic():
	for i in range(0, 20):
		var p = puzzle_equations_basic.new(10)
		p.generate()
		print(p.display_problem())
		print(p.options)
		print(p.solution)
		print("___________________")
