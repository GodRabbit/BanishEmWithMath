extends Node

# copyright 2021,2022 Dor "GodRabbit" Shlush
# this file is part of "BanishEmWithMath"

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

var top_story_dict = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	var file = File.new()
	file.open("res://data/top_story_data.json", file.READ)
	var text = file.get_as_text()
	var res = JSON.parse(text) #parse text to dictionary
	top_story_dict = res.result #save the result
	file.close() #close file


func get_top_story_by_id(id : String) -> Dictionary:
	if top_story_dict.has(id):
		return top_story_dict[id]
	else:
		return {}

# Returns an array of all the stories (ids) fitting the specified zone id
func get_top_stories_by_zone(zone_id : String) -> Array:
	var result = []
	for id in top_story_dict:
		# this top story has this zone?
		if top_story_dict[id]["zones"].has(zone_id):
			result.append(id)
	return result
