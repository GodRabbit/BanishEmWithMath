extends Node

# copyright 2021,2022 Dor "GodRabbit" Shlush
# this file is part of "BanishEmWithMath"

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

# global class for holding the data of all the items in the game.
var items_data_dict = {}


# Called when the node enters the scene tree for the first time.
func _ready():
	var file = File.new()
	file.open("res://data/items_data.json", file.READ)
	var text = file.get_as_text()
	var res = JSON.parse(text) #parse text to dictionary
	items_data_dict = res.result #save the result
	file.close() #close file

func get_random_item_id():
	randomize()
	var index = randi() % items_data_dict.keys().size()
	var key = items_data_dict.keys()[index]
	return key

func get_item_by_id(id):
	if items_data_dict.has(id):
		return items_data_dict[id]
	else:
		return {}

func get_item_price(item_id):
	var it = get_item_by_id(item_id)
	return it["price"]

# gets a dictionary of items ids (keys) and amounts
#  returns the average gems price of those items
func get_average_gems(items_list : Dictionary) -> float:
	var sum = 0
	var count = 0
	for id in items_list.keys():
		sum += get_item_price(id)*items_list[id]
		count += items_list[id]
	return float(sum)/float(count)

# gets a dictionary of items ids (keys) and amounts
#  returns the total gems price of those items
func get_total_gems(items_list : Dictionary) -> int:
	var sum = 0
	for id in items_list.keys():
		sum += get_item_price(id)*items_list[id]
	return sum
