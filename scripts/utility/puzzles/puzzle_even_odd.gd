extends puzzle_abstract


# an abstract class for even and odd numbers detection.
# Each time the player will have to find either the even or the odd 
# among the 6 numbers in the options.

class_name puzzle_even_odd

var max_val

func _init(_max_val = 20):
	max_val = _max_val

func generate():
	randomize()
	var parity = randi() % 2
	data = {"parity":parity}
	
	var a = [] # the array the we will taking the solution from
	var bank = [] # the bank for wrong options
	for i in range(0, max_val + 1):
		if i%2 == parity:
			a.append(i)
		else:
			bank.append(i)
	
	# choose a random element from the array <a>
	# to be the solution 
	var index = randi() % a.size()
	solution = a[index]
	
	# pick wrong options:
	_pick_options_from_bank(bank)

func display_problem():
	if data["parity"] == 0:
		return "Find the even number"
	else:
		return "Find the odd number"
