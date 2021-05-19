extends Node

# DEPRECATED IN THIS PROJECT
# an abstract class that represents a crafting recipe.
# to add a recipe register it on "crafting_recipes"

class_name crafting_recipe

# a dictionary of items_ids with amount as values.
var ingredients = {} # if empty the recipe just generate new resources from puzzle
var results = {} # should not be empty.

# the puzzle needed to solve for processing this crafting recipe
var puzzle : puzzle_abstract 

var time = 40 # in seconds. how much time the problem has to be solved.

var energy = 7 # how much energy this crafting recipe take from the player. 

# id to recollect this recipe.
var crafting_id = "_empty_"

# display name of the recipe.
var crafting_name = "_empty_"

# DEPRECATED
# the tile id that pop this recipe.
# only 1 id per crafting recipe.
# "none" means any tile can craft this recipe.
var _tile_id = "none"

func _init(_id, _name, _ings, _ress, _puzzle, _time = 60, _energy = 0, _tile_id = "none"):
	crafting_id = _id
	crafting_name = _name 
	ingredients = _ings
	results = _ress
	puzzle = _puzzle
	time = _time
	energy = _energy

func get_crafting_id():
	return crafting_id

func get_crafting_name():
	return crafting_name

func get_ingredients():
	return ingredients

func get_results():
	return results

func get_puzzle():
	return puzzle

func get_time():
	return time

func get_energy():
	return energy

func _to_string():
	var s = ""
	for k in ingredients.keys():
		s = s + str(ingredients[k]) + " " + k +","
	s = s +"-->"
	for k in results.keys():
		s = s + str(results[k]) + " " + k +","
	return s
