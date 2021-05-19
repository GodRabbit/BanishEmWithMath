extends puzzle_abstract

class_name puzzle_prime_detection

# Prime detection. class variable max_value for whats the largest number that
# can appear (default 100). All the composite numbers options are always odd 

var max_val = 100

func _init(_max_val = 100):
	max_val = _max_val

func generate():
	# create 2 arrays. of primes and composite odd numbers for the bank
	var bank = []
	var primes = []
	for i in range(0, max_val + 1):
		if math_util.is_prime(i):
			primes.append(i)
		else:
			if i % 2 != 0:
				bank.append(i)
	
	randomize()
	var index = randi() % primes.size()
	solution = primes[index]
	
	_pick_options_from_bank(bank)

func display_problem():
	return "Find the prime number!"
