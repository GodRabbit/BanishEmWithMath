extends puzzle_abstract

class_name puzzle_multi_compound

# In this puzzle the problem is a multiplication problem but all options
# are addition problems. The puzzle parameter is the max value of multiplicants
# its advisable to not go beyond 12. 
# example:
# problem: 4 X 5 = ???
# Solutions: 4 + 15, 13 + 12, 14 + 6, and so on..

var max_val = 12

func _init(val = 12):
	max_val = 12

func generate():
	randomize()
	var x = 1 + randi() % max_val
	var y = 1 + randi() % max_val
	data = {"x": x, "y": y}
	
	# proto-solution:
	var s = x*y
	
	# that actual solution is an array of 2 numbers, who's sum is s
	var arr = math_util.split(s)
	
	# choose a random element from arr:
	var index = randi() % arr.size()
	solution = arr[index]
	
	# now we need to choose the bank
	var bank = []
	
	var min_search = int(max(s - 20, 0)) # the minimum of the search in the bank; this way the value is never below zero
	for i in range(min_search, s + 20):
		if i != s:
			var barr = math_util.split(i)
			for j in barr:
				bank.append(j)
	_pick_options_from_bank(bank)

# returns a string that indicates how the problem will be presented
# in the displayer scene.
func display_problem() -> String:
	return "%d X %d = ???" % [data["x"], data["y"]]

# val is an array of size 2
func display_option(val):
	randomize()
	var num = randi() % 2
	if num == 0:
		return "%d + %d" % [val[0], val[1]]
	else:
		return "%d + %d" % [val[1], val[0]]
