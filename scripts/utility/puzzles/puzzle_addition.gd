extends "res://scripts/utility/puzzles/puzzle_abstract.gd"


# an abstract puzzle of addition. create general addition problems

class_name puzzle_addition

func generate():
	randomize()
	var x = randi() % 50
	var y = randi() % 50
	data = {"x": x, "y": y}
	solution = x + y
	
	# create the wrong answers:
	
	# create a bank of options:
	var bank = []
	for i in range(solution - 5, solution + 6):
		if i != solution:
			bank.append(i)
	
	# choose a random 5 wrong answers from the bank
	_pick_options_from_bank(bank)

# returns a string that indicates how the problem will be presented
# in the displayer scene.
func display_problem() -> String:
	return "%d + %d = ???" % [data["x"], data["y"]]
