extends puzzle_abstract

# copyright 2021,2022 Dor "GodRabbit" Shlush
# this file is part of "BanishEmWithMath"

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

class_name puzzle_prime_detection

# Prime detection. class variable max_value for whats the largest number that
# can appear (default 100). All the composite numbers options are odd based on
# whrther this is easy mode or not.

var max_val = 100

# in easy mode all non primes can appear in the options, 
# not easy = only odd non primes can appear in the options
var is_easy = true

func _init(_max_val = 100, _easy_mode = true):
	max_val = _max_val
	is_easy = _easy_mode

func generate():
	# create 2 arrays. of primes and composite odd numbers for the bank
	var bank = []
	var primes = []
	for i in range(0, max_val + 1):
		if math_util.is_prime(i):
			primes.append(i)
		else: # i is not prime
			if is_easy: # in easy mode, i will be added to the bank automatically
				bank.append(i)
			else: # not easy: only odds are added:
				if i % 2 != 0:
					bank.append(i)
	
	randomize()
	var index = randi() % primes.size()
	solution = primes[index]
	
	_pick_options_from_bank(bank)

func display_problem():
	return "Find the prime number!"
