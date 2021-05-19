extends "res://scripts/utility/puzzles/puzzle_abstract.gd"

class_name puzzle_division_simple

func generate():
	randomize()
	var y = 1 + randi() % 11
	var s = randi() % 11
	var x = y * s
	data = {"x": x, "y": y}
	solution = s
	
	# generate the bank of wrong answers
	var bank = []
	for i in range(1, 4):
		_check_and_add(bank, s + i)
		_check_and_add(bank, s - i)
		
		var y_fake = y - i
		var s_fake 
		if y_fake != 0:
			s_fake = int(x/y_fake)
			if s_fake != s:
				_check_and_add(bank, s_fake)
		
		y_fake = y + i
		if y_fake != 0:
			s_fake = int(x/y_fake)
			if s_fake != s:
				_check_and_add(bank, s_fake)
	
	# bank may have too few options, fix it: 
	if bank.size() < 5:
		for i in range(-5, 5):
			_check_and_add(bank, s + i)
	
	if bank.size() < 5:
		for i in range(0, 20):
			_check_and_add(bank, randi() % 20)
	_pick_options_from_bank(bank)

# returns a string that indicates how the problem will be presented
# in the displayer scene.
func display_problem() -> String:
	return "%d : %d = ???" % [data["x"], data["y"]]
