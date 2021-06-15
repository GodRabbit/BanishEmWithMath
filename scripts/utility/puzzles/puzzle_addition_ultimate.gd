extends "res://scripts/utility/puzzles/puzzle_abstract.gd"


# addition\subtraction with negatives and more than one number added

var max_val = 100

# how many numners we add\subtract
var min_count = 2
var max_count = 5

func _init(_max_val = 100, _min_count = 2, _max_count = 4):
	max_val = _max_val
	min_count = _min_count
	max_count = _max_count

