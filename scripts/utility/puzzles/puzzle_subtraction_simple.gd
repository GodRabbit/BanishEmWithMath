extends puzzle_abstract

class_name puzzle_subtraction

# an abstract class for subtraction problems
# the problem will be 
# x - y = s

var max_val

func _init(_max_val = 30):
	max_val = _max_val

func generate():
	randomize()
	var y = randi() % max_val
	var s = randi() % max_val
	var x = y + s
	data = {"x": x, "y": y}
	solution = s
	
	# create the wrong answers:
	
	# create a bank of options:
	var bank = []
	var m = int(max(solution - 10, 0))
	for i in range(m, solution + 10):
		if i != solution:
			bank.append(i)
	
	# choose a random 5 wrong answers from the bank
	_pick_options_from_bank(bank)

# returns a string that indicates how the problem will be presented
# in the displayer scene.
func display_problem() -> String:
	return "%d - %d = ???" % [data["x"], data["y"]]
