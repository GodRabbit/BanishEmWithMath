extends puzzle_abstract

class_name puzzle_multi_simple

func generate():
	randomize()
	var y = randi() % 13
	var x = randi() % 13
	data = {"x": x, "y": y}
	var s = x * y
	solution = s
	
	# create the wrong answers:
	
	var bank = [] # bank of wrong answers
	# create a bank of options:
	for i in range(1, 3):
		_check_and_add(bank, s + i)
		_check_and_add(bank, s - i)
		_check_and_add(bank, x * (y + i))
		_check_and_add(bank, x * (y - i))
		_check_and_add(bank, (x + i)*y)
		_check_and_add(bank, (x - i)*y)
	
	# if the bank is too small, add garbage to it:
	if bank.size() < 5:
		var m = int(max(s - 20, 0))
		for i in range(m, s + 20):
			if i != s:
				_check_and_add(bank, i)
	
	_pick_options_from_bank(bank)

# returns a string that indicates how the problem will be presented
# in the displayer scene.
func display_problem() -> String:
	return "%d X %d = ???" % [data["x"], data["y"]]
