extends Reference

# copyright 2021,2022 Dor "GodRabbit" Shlush
# this file is part of "BanishEmWithMath"

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

# an abstract class to represent an item stack in the inventory.
# [an inventory is basically just array of item stacks.]
# an item stack can be empty if  item id == "none" or item_amount = 0.
# it is the fundmental element of a physical inventory 

class_name item_stack

# what is the max amount of items in a stack:
const max_amount = 999

var item_id = "none"
var item_amount = 0

# init the stack, default is empty stack
func _init(_id = "none", _amount = 0):
	item_id = _id
	item_amount = _amount

# DELETES the content of the current stack and replaces it with
# a new item and amount
func set_stack(_id, _amount):
	item_id = _id
	item_amount = _amount

# changes the current amount with <_amount>
# returns true qhen the stack ends in the correct amount
# and false when the stack is reduced too much below 0 or too much
# above the max: in this case the value wont update.
func set_amount(_amount):
	if(_amount == 0):
		item_id = "none"
		item_amount = 0
		return true
	elif _amount < 0:
		return false
	elif(_amount > max_amount):
		return false
	else:
		item_amount = _amount
		return true

func add_amount(a):
	set_amount(get_amount() + a)

func get_amount():
	return item_amount

func get_item_id():
	return item_id

func equals(stack):
	if stack.get_item_id() == get_item_id() && get_amount() == stack.get_amount():
		return true
	else:
		return false

func empty_stack():
	item_id = "none"
	item_amount = 0

func is_empty():
	if item_id == "none" || item_amount == 0:
		return true
	else:
		return false

func set_to_max():
	set_amount(max_amount)

# how much more space the item stack has
func get_empty_space():
	return max_amount - item_amount

func _to_string():
	return "["+item_id+","+str(item_amount)+"]"
