extends Button

# copyright 2021,2022 Dor "GodRabbit" Shlush
# this file is part of "BanishEmWithMath"

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

var stack = item_stack.new()

const FILE_PATH = "res://images/items/%s.png"

# nodes
onready var texture_rect = $texture_rect
onready var item_label = $texture_rect/item_label

# Called when the node enters the scene tree for the first time.
func _ready():
	set_item(item_stack.new("none", 0))
	group = load("res://scenes/gui/button_groups/item_buttons.tres")

func set_item(_stack):
	stack = _stack
	update_gui()

func update_gui():
	var item = items_data.get_item_by_id(stack.get_item_id())
	if item.size() > 0 or !stack.is_empty():
		item_label.text = str(stack.get_amount())
		
		# check item texture exists.
		var path = FILE_PATH % item["id"]
		
		# load image without checking
		texture_rect.texture = load(path)
		
		# check before loading:
		# causes problems on export; can't seem to fix this...
#		var file2Check = File.new()
#		var doFileExists = file2Check.file_exists(path)
#		if doFileExists:
#			icon = load(path)
#		else:
#			icon = load(FILE_PATH % "none")
		
		disabled = false
	else:
		# empty stack is just empty...
		item_label.text = ""
		texture_rect.texture = null
		disabled = true
