extends Control

# copyright 2021,2022 Dor "GodRabbit" Shlush
# this file is part of "BanishEmWithMath"

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

# the puzzle
var puzzle #: puzzle_abstract

# choose the option which displays the correct answer
var correct_option = 0

#nodes:
onready var accept_button = $accept_button
onready var problem_label = $problem_label
onready var options_container = $options_container

signal answer_clicked(correct)

# Called when the node enters the scene tree for the first time.
func _ready():
	accept_button.connect("pressed", self, "on_accept_button_pressed")

func set_puzzle(_puzzle):
	puzzle = _puzzle
	puzzle.generate()
	unpress_all_buttons()
	update_gui()

func create_new_puzzle():
	puzzle.generate()
	update_gui()

# make all the button unpressed
func unpress_all_buttons():
	for c in options_container.get_children():
		c.pressed = false

# updates the gui for correct display
# call this after changing the puzzle
func update_gui():
	# displays the problem:
	# Rich text: problem_label.bbcode_text = "\n[center]"+puzzle.display_problem()+"[/center]"
	problem_label.text = puzzle.display_problem()
	# displays the options:
	randomize()
	# choose the option which displays the correct answer:
	correct_option = randi() % 6
	
	# duplicate the options to prevent loss of data.
	var options_copy = puzzle.get_options().duplicate()
	
	for i in range(0, 6):
		if i == correct_option:
			get_node("options_container/option_button"+str(i)).text = puzzle.display_option(puzzle.get_solution())
		else:
			get_node("options_container/option_button"+str(i)).text = puzzle.display_option(options_copy.pop_front())
		
func on_accept_button_pressed():
	if get_node("options_container/option_button"+str(correct_option)).pressed:
		emit_signal("answer_clicked", true)
		return
	for i in range(0, 6):
		if i != correct_option:
			if get_node("options_container/option_button"+str(i)).pressed:
				emit_signal("answer_clicked", false)
				return
