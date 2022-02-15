extends Reference

# copyright 2021,2022 Dor "GodRabbit" Shlush
# this file is part of "BanishEmWithMath"

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

class_name math_util
# a named class with many static functions to help with calculations for the 
# puzzles classes.

const PRIMES = [2,3,5,7,11,13,17,19,23,29,31,37,41,43,47,53,59,61,67,71,73,79,
83,89,97,101]


# return an array of arrays with 2 elements that represent all the ways
# to add to x.
# example for x = 5, the function will return:
# [[1, 4], [2, 3]] 
# notice how there are no duplicates like [1, 4] & [4, 1].
static func split(x):
	# special cases, 1, 0:
	if x == 0:
		return [[0, 0]]
	elif x == 1:
		return [[1, 0]]
	# else:
	var result = []
	for i in range(1, int(x/2) + 1):
		var a = [i, x - i]
		result.append(a)
	return result

# return an array of arrays with 2 elements that represents all 
#  the ways to subtract to x. The largest subtractee is max_val
# e.g. for x = 5:
# [[6, 1], [7,2], [8, 3], [9, 4], [10, 5], [11,6],...[5 + max_val,max_val]]
static func subtract_split(x, max_val):
	# special cases, 1, 0:
	if x == 0:
		return [[0, 0]]
	elif x == 1:
		return [[1, 0]]
	var result = []
	for i in range(1, max_val + 1):
		var a = [x + i, i]
		result.append(a)
	return result

# splits <x> into an array of size <num>.
#  returns an array whose elements' sum is x. elements are positive
#  running time: O(num)
# pick random numbers and sum them.
# then multply each by (x/sum)
# such that the new sum will be x.
# since there will be residue -> the difference will be divided
# randomly by the slots in the resulted array
static func split_into(x, num):
	var result = []
	randomize()
	
	# generate random elements and sum them
	var sum = 0
	for i in range(0, num):
		var n = randi()
		result.append(n)
		sum += n
	
	# multiply each element by x/sum and sum them again:
	var n_sum = 0 # new sum
	for i in range(0, num):
		result[i] = int((x/sum)*result[i])
		n_sum += result[i]
	
	# split the difference randomly between the array slots
	if n_sum < x:
		var diff = x - n_sum
		for i in range(0, diff):
			var index = randi() % result.size()
			result[index] = result[index] + 1
	
	return result

# returns a dictionary of pairs of numbers (< max_val) such that their
# multiplication is the key. No duplicate pairs allowed
# i.e. pairs[6] = [[2,3]]
# pairs[24] = [[3,8], [6,4], [2, 12]]
static func split_divisors(max_val):
	# insert all the pairs of numbers' multiplication into a dictionary
	# e,g pairs[6] = [[2,3]]
	# pairs[30] = [[15,2],[6,5],[3,10],[10,3]]
	var pairs = {}
	for i in range(2, max_val + 1):
		for j in range(2, i + 1):
			if pairs.has(i*j):
				pairs[i*j].append([i, j])
			else:
				pairs[i*j] = [[i, j]]
	return pairs

# randomly choose a random element of the array arr.
static func _choose_random_element(arr : Array):
	randomize()
	var index = randi() % arr.size()
	return arr[index]

# splits <x> into an array of size <num> which includes
#  both positive and negative numbers. X> 1
#  (1) Split this number into subtraction or addition?
#  (2) this creates 2 array slots. choose 1 of them randomly
#  (3) repeat 1. until you have an array of size num
static func ultimate_split_into(x, num):
	var result = []
	randomize()
	var n = randi() % 2
	if n == 0:
		result = _choose_random_element(split(x))
	else:
		result = _choose_random_element(subtract_split(x, x))
		result[1] = -result[1]
	while result.size() < num:
		# pick a random array index:
		var index = randi() % result.size()
		
		n = randi() % 2
		if n == 0: # split into addition:
			var y = result[index]
			if y == 1:
				var arr = [1, 0]
				result[index] = arr[0]
				result.insert(index + 1, arr[1])
			elif y == -1:
				var arr = [0, -1]
				result[index] = arr[0]
				result.insert(index + 1, arr[1])
			elif y == 0:
				var arr = [0, 0]
				result[index] = arr[0]
				result.insert(index + 1, arr[1])
			elif y > 0:
				var arr = _choose_random_element(split(y))
				result[index] = arr[0]
				result.insert(index + 1, arr[1])
			elif y < 0:
				var arr = _choose_random_element(split(-y))
				# both elements are now positive, but need to be negative in the array
				result[index] = -arr[0]
				result.insert(index + 1, -arr[1])
		else: # split into subtraction
			var y = result[index]
			if y >= 0:
				var arr = _choose_random_element(subtract_split(y, y))
				result[index] = arr[0]
				result.insert(index + 1, -arr[1])
			elif y < 0:
				var arr = _choose_random_element(subtract_split(-y, -y))
				result[index] = -arr[0]
				result.insert(index + 1, +arr[1])
	return result

# returns true\false based on if x is prime or not
static func is_prime(x):
	if x == 2:
		return true
	if x == 1 or x == 0 or x % 2 == 0:
		return false
	if x <= 101:
		if x in PRIMES:
			return true
		else:
			return false
	else:
		# check all the odd numbers between 3 to sqrt(x)
		# if x is divisible by one of them, return false. if x is not divisible
		# by none of them then x is prime
		var s = int(sqrt(x)) + 2
		for i in range(3, s, 2):
			if x % i == 0:
				return false
		
		return true

# pick <amount> of unique random primes smaller than <max_num>
static func pick_prime(max_num, amount):
	var prime_list = []
	for i in range(2, max_num):
		if is_prime(i):
			prime_list.append(i)
	
	if prime_list.size() <= amount:
		return prime_list
	
	var result = []
	for i in range(0, amount):
		randomize()
		var index = randi() % prime_list.size()
		result.append(prime_list[index])
		prime_list.remove(index)
	return result

# get a list of numbers which has only 2 or 5 as prime divisors
# max_power is the largest power possible for either
# best results for max_power = 3
static func get_easy_denom_list(max_power):
	var result = []
	for i in range(0, max_power):
		for j in range(0, max_power):
			var two = int(pow(2.0, i))
			var five = int(pow(5.0, j))
			result.append(two*five)
	result.erase(1)
	return result

# divide x by y. y must be smaller than x
# return an array of 2 numbers [q, r]
# the first element is the quotient and second is the remainder
static func divide(x : int, y: int):
	var result = []
	result.append(int(x/y))
	result.append(x % y)
	return result

# puts negative numbers inside parenthesis
static func display_number(num):
	if num < 0:
		return "(%d)" % num
	else:
		return str(num)

static func calculate(operation, num1, num2):
	match operation:
		"+":
			return num1+num2
		"-":
			return num1-num2
		"*":
			return num1*num2
		":":
			return num1/num2
		"%":
			return num1%num2
		_:
			return null

# gets a dictionary of keys and weights, returns a random key
# based on the weights
static func get_random_key(d : Dictionary):
	var total = 0
	for k in d.keys():
		total += d[k]
	
	randomize()
	var number = randi() % (total + 1)
	
	total = 0
	for k in d.keys():
		total += d[k]
		if total >= number:
			return k
	
	return d.keys()[d.keys().size() - 1]

static func gcd(a, b):
	if b == 0:
		return int(max(a, -a))
	else:
		return gcd(b, a % b)

# given an array of numbers
# return an array of 2 elements, the first element is
#  the max value, and the other element is all the rest of the elements (in array)
static func find_max(arr : Array):
	var index_max = 0 # the index of the largest element
	var num_max = arr[0]
	
	for i in range(1, arr.size()):
		if arr[i] > num_max:
			num_max = arr[i]
			index_max = i
	
	var result = [arr[index_max]]
	var rest = arr.duplicate()
	rest.remove(index_max)
	result.append(rest)
	return result

static func find_min(arr : Array):
	var index_min = 0 # the index of the largest element
	var num_min = arr[0]
	
	for i in range(1, arr.size()):
		if arr[i] < num_min:
			num_min = arr[i]
			index_min = i
	
	var result = [arr[index_min]]
	var rest = arr.duplicate()
	rest.remove(index_min)
	result.append(rest)
	return result

# picks a number at random beteen 6 - > max_val, and 5 distinct smaller numbers
#  the returned array has the max as the first element, and the rest
#  are an array within array
#  example [30, [1, 21, 8, 4, 7]]
static func pick_max_number(max_val):
	var M = int(max(6, max_val))
	randomize()
	# pick a random number for the max number.
	var solution = 6 + randi() % (M - 5)
	
	# pick 5 random numbers smaller than the solution:
	var numbers = range(0, solution)
	
	var arr = []
	for i in range(0, 5):
		var index = randi() % numbers.size()
		arr.append(numbers[index])
		
		numbers.remove(index)
	
	return [solution, arr]

# picks a number at random beteen 6 - > max_val, and 5 distinct bigger numbers
#  the returned array has the min as the first element, and the rest
#  are an array within array
#  example [13, [14, 99, 56, 23, 40]]
static func pick_min_number(max_val):
	var M = int(max(6, max_val))
	randomize()
	# pick a random number for the min number.
	var solution = 0 + randi() % (M - 5)
	
	# pick 5 random numbers bigger than the solution:
	var numbers = range(solution + 1, M + 1)
	
	var arr = []
	for i in range(0, 5):
		var index = randi() % numbers.size()
		arr.append(numbers[index])
		
		numbers.remove(index)
	
	return [solution, arr]  

# turns miliseconds into a dictionary of the form 
# ["hrs":<hours>, "mnts":<minutes>, "secs":<seconds>, "ms":<miliseconds>]
static func ms_to_time_dictionary(ms):
	# how many seconds:
	var secs = int(ms / 1000)
	
	var _ms = int((ms % 1000)/100)
	
	# how many minutes it is:
	var mnts = int(secs/60)
	
	# get the reminder of the seconds
	secs = secs % 60
	
	# how many hours it is:
	var hrs = int(mnts/60)
	
	# get the reminder of the minutes:
	mnts = mnts % 60
	
	var d = {"secs":secs, "hrs":hrs, "mnts":mnts, "ms":_ms}
	return d

static func get_month_abbr_from_number(month):
	match month:
		1:
			return "Jan"
		2:
			return "Fab"
		3:
			return "Mar"
		4:
			return "Apr"
		5:
			return "May"
		6:
			return "Jun"
		7:
			return "Jul"
		8:
			return "Aug"
		9:
			return "Sep"
		10:
			return "Oct"
		11:
			return "Nov"
		12:
			return "Dec"

class base_transform:
	# a class for changing bases
	
	var d = 0 # decimal number
	
	func _init(_d):
		d = _d
	
	func set_number(_d):
		d = _d
	
	func get_number():
		return d
	
	# turns d into a number in base b
	# returns an array of the digits
	func to_base(b : int):
		# puts the new digits inside an array for printing
		var arr = []
		
		var x = d
		while x != 0:
			arr.append(x % b)
			x = int(x/b)
		
		return arr

	 
	# turn an array of digits into a number d
	func from_base(arr : Array, base):
		# gets d from an array <arr> and base <base>
		d = 0
		
		for i in range(0, arr.size()):
			d += arr[i]*int(pow(base, i))
		
		return d
	
	func digits_to_str(arr):
		# print in reverse order
		var result = ""
		for i in range(0, arr.size()):
			result += str(arr[arr.size() - i - 1])
		return result
