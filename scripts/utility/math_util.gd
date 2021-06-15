extends Node

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
	var result = []
	for i in range(1, int(x/2) + 1):
		var a = [i, x - i]
		result.append(a)
	return result

# return an array of arrays with 2 elements that represent all the ways
# to add to x or subtract to x (including negatives). "max_val" is the largest
# number that the numbers can be (absolute value)
# no duplicates are returned.
static func ultimate_split(x, max_val):
	var result = []
	for i in range(-max_val, max_val):
		pass

# attempts to split value <val> into an array of arrays, each of size <amount>
# such that their sum is <val>. A generalization of the 'split' function
static func general_split(val, amount):
	pass

# returns true\false based on if x is prime or not
static func is_prime(x):
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

# divide x by y. y must be smaller than x
# return an array of 2 numbers [q, r]
# the first element is the quotient and second is the remainder
static func divide(x : int, y: int):
	var result = []
	result.append(int(x/y))
	result.append(x % y)
	return result

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
