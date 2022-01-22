extends Control

# copyright 2021,2022 Dor "GodRabbit" Shlush
# this file is part of "BanishEmWithMath"

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

# a gui class for displaying the news stories the player unlocked

# nodes:
onready var header_button = $panel/main_container/header_button
onready var scrol_container = $panel/main_container/scroll_container
onready var header_label = $panel/main_container/scroll_container/content_container/header_label
onready var body_label = $panel/main_container/scroll_container/content_container/body_label
onready var signature_label = $panel/main_container/scroll_container/content_container/signature_label
onready var left_button = $panel/main_container/button_container/left_button
onready var right_button = $panel/main_container/button_container/right_button
onready var close_button = $panel/main_container/button_container/close_button

signal request_exit

# Called when the node enters the scene tree for the first time.
func _ready():
	close_button.connect("pressed", self, "on_close_button_pressed")
	header_button.connect("pressed", self, "on_close_button_pressed")
	left_button.connect("pressed", self, "on_left_button_pressed")
	right_button.connect("pressed", self, "on_right_button_pressed")
	setup_stories()

var stories_ids = []
var current_index = 0

func setup_stories():
	stories_ids = player_data.get_seen_stories()
	current_index = stories_ids.size() - 1
	update_gui()

func update_gui():
	if stories_ids.size() == 0:
		header_label.text = "No New Stories"
		body_label.text = ""
		signature_label.text = ""
		left_button.disabled = true
		right_button.disabled = true
	else:
		if current_index < 0:
			current_index = stories_ids.size() - 1
		# arrows button handeling:
		if current_index == 0:
			left_button.disabled = true
			right_button.disabled = false
		elif current_index == stories_ids.size() - 1:
			left_button.disabled = false
			right_button.disabled = true
		else:
			left_button.disabled = false
			right_button.disabled = false
		
		# load the story into the displayer:
		var story_id = stories_ids[current_index]
		var story_dict = top_story_data.get_top_story_by_id(story_id)
		header_label.text = story_dict["header"]
		body_label.text = story_dict["body"]
		
		# deal with the signature:
		var date_str = _generate_random_date_string()
		var writer = story_dict["writer"]
		signature_label.text = "%s by %s" % [date_str, writer]
		
		# scroll to 0:
		scrol_container.scroll_vertical = 0
		

func _generate_random_date_string():
	randomize()
	var day = 1 + randi() % 28
	var month = 1 + randi() % 12
	var s = "%s, %d," % [math_util.get_month_abbr_from_number(month), day]

func on_close_button_pressed():
	emit_signal("request_exit")

func on_left_button_pressed():
	if current_index == 0:
		return
	else:
		current_index = current_index - 1
		update_gui()

func on_right_button_pressed():
	if current_index == stories_ids.size() - 1:
		return
	else:
		current_index = current_index + 1
		update_gui()
