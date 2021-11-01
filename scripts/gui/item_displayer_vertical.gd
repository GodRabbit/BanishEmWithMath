extends Control

# copyright 2021 Dor "GodRabbit" Shlush
# this file is part of "BanishEmWithMath"

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

# a gui class that represents an item in vertical form.
# great for crafting ui.

var stack = item_stack.new()

const FILE_PATH = "res://images/items/%s.png"

# nodes:
onready var item_texture = $main_container/item_texture
onready var item_name_label = $main_container/item_name_label
onready var item_amount_label = $main_container/item_texture/item_amount_label

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	# set_item(item_stack.new("apple", 15))

func set_item(_stack):
	stack = _stack
	update_gui()

func update_gui():
	var item = items_data.get_item_by_id(stack.get_item_id())
	if item.size() > 0:
		item_name_label.text = item["name"]
		item_amount_label.text = str(stack.get_amount())
		
		# check item texture exists.
		var path = FILE_PATH % item["id"]
		item_texture.texture = load(path)
		
#		var file2Check = File.new()
#		var doFileExists = file2Check.file_exists(path)
#		if doFileExists:
#			item_texture.texture = load(path)
#		else:
#			item_texture.texture = load(FILE_PATH % "none")
#	else:
#		item_name_label.text = ""
#		item_texture.texture = load(FILE_PATH % "none")
#		item_amount_label.text = ""
	
