extends Reference

# copyright 2021,2022 Dor "GodRabbit" Shlush
# this file is part of "BanishEmWithMath"

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

# a class to represnts an inventory with a specific size. Can be used for 
# player, chests, npcs and more. this is based a physical inventory, where each cell
# can hold 1 item up to certain max amount (999)
# its just a collection of itemstacks. starts empty.
class_name inventory

var size = 1

var item_slots = []

func _init(_size):
	size = _size
	empty_inventory()

func get_size():
	return size

func get_stack_at(index):
	if index < size:
		return item_slots[index]
	else:
		return null

func empty_inventory():
	item_slots = []
	for i in range(0, size):
		item_slots.append(item_stack.new())

# try to add item into the inventory, if auto sort is on, try to find
# if there's already item like this in the inventory and insert it there
# otherwise its just goes to the first  empty slot.
# it returns the residue of the item insertion, as an array with 2 values
# [<item_id>, <amount>]. if it return an empty array it means the item was completely
# added to the inventory.
func add_item(item_id, item_amount, auto_sort = true):
	if item_id == "none" || item_amount == 0:
		return []
	var n_amount = item_amount
	if auto_sort:
		# var found = false; NOT NEEDED!
		for s in item_slots:
			if s.get_item_id() == item_id:
				# stack <s> has space: 
				if s.get_empty_space() >= n_amount:
					# insert the amount into <s>
					s.add_amount(n_amount)
					return [] # the item finished inserting
				else:
					# fill s as much as possible, and continue looking for more
					# spaces to insert
					n_amount = n_amount - s.get_empty_space()
					s.set_to_max()
		
		# wev'e looped through every item and inserted where the item matched
		# getting to this point means there are more items that need to be 
		# inserted but this time into empty slots:
		
		# look for empty slots:
		for s in item_slots:
			if s.is_empty():
				if n_amount <= s.max_amount:
					s.set_stack(item_id, n_amount)
					return []
				else:
					n_amount = n_amount - s.max_amount
					s.set_stack(item_id, s.max_amount)
		
		# if we still has some amount of items left:
		if n_amount > 0:
			return [item_id, n_amount]
		else:
			return []
	else: 
		# auto sort off, just find the first empty space(s) and insert the item 
		#into it
		
		# look for empty slots:
		for s in item_slots:
			if s.is_empty():
				if n_amount <= s.max_amount:
					s.set_stack(item_id, n_amount)
					return []
				else:
					n_amount = n_amount - s.max_amount
					s.set_stack(item_id, s.max_amount)
		
		# if we still has some amount of items left:
		if n_amount > 0:
			return [item_id, n_amount]
		else:
			return []
		

# add inventory <inv> into this inventory. return a residue dictionary.
# {"<item_id1>":<amount1>,....}
# automatically auto-sorts to prevent errors. if later its needed we can add
# an option to prevent auto-sort.
func add_inventory(inv : inventory):
	var residue = {}
	for i in range(0, inv.get_size()):
		# get the current stack at inv and get the item to add
		var s = inv.get_stack_at(i)
		var a = add_item(s.get_item_id(), s.get_amount())
		
		# if there's residue from this insert,
		# add it to the dictionary.
		if a.size() > 0:
			# a[0] is item id, a[1] is amount.
			# if there's already an item id like this in the residue, 
			#add them together. otherwise create new entry
			if residue.has(a[0]):
				residue[a[0]] = residue[a[0]] + a[1]
			else:
				residue[a[0]] = a[1]
	
	return residue

# add the dictionary dict, must be of the form:
# {"<item_id1>":<amount1>,....}
# return residue of the items that couldn't insert.
func add_dictionary(dict : Dictionary):
	var residue = {}
	for k in dict.keys():
		var a = add_item(k, dict[k])
		
		# if there's residue from this insert,
		# add it to the dictionary.
		if a.size() > 0:
			# a[0] is item id, a[1] is amount.
			# if there's already an item id like this in the residue, 
			#add them together. otherwise create new entry
			if residue.has(a[0]):
				residue[a[0]] = residue[a[0]] + a[1]
			else:
				residue[a[0]] = a[1]
	return residue

# returns the total amount of "item_id" in the inventory
# can be used to check if an item is in the inventory
func get_total_amount(item_id):
	var total = 0
	for s in item_slots:
		if s.get_item_id() == item_id:
			total += s.get_amount()
	return total

# checks if the inventory can accept 
# a bunch of items, that represnted by a dictionary <dict> of the form
# {"<item_id1>":<amount1>, "<item_id2>":<amount2>, "<item_id3>":<amount3>,...}
# return true if the inventory can do this and false otherwise.
func can_insert(dict : Dictionary):
	# backup the slots array smartly, try to add all the items one by one
	# if there is residue -> return false.
	
	# later return the slots back to normal.
	# temp backup of the item slots.
	var item_slots_temp = []
	
	for i in item_slots:
		item_slots_temp.append(item_stack.new(i.get_item_id(), i.get_amount()))
	
	# attempt to insert the items into the duplicated inventory
	# if all the items were inserted without a problem, return true
	# of course, if one of the items werent inserted -> return false
	for k in dict.keys():
		var s = add_item(k, dict[k])
		if s.size() != 0:
			item_slots = item_slots_temp.duplicate()
			return false
	item_slots = item_slots_temp.duplicate()
	return true

# attempt to remove <amount> of <item_id>. in case of success return true,
# else: return false
func remove_item(item_id, amount):
	# not enough to remove
	if get_total_amount(item_id) < amount:
		return false
	
	var n_amount = amount
	for s in item_slots:
		if s.get_item_id() == item_id && n_amount > 0:
			if s.get_amount() < n_amount: # if this stack dont have enough to finish the requested amount
				n_amount = n_amount - s.get_amount()
				s.empty_stack()
			else: # there's enough of this item in this stack, so you could just return
				s.add_amount(-n_amount)
				return true
	
	if n_amount == 0:
		return true
	else: # there shouldnt be any reason for this to happen!!
		return false

# attempt to remove the amount specified from the stack at index <index>
# if empty, do nothing.
# if the amount specified is more than what exist, empty the stack
# if any of the above happen -> return true.
# if the inventory doesn't have this index -> return false
func remove_item_at(index, amount = 1) -> bool:
	if index < item_slots.size():
		if item_slots[index].get_amount() >= amount:
			# if there's enough of the amount at stack to remove
			item_slots[index].add_amount(-amount)
		else: # the amount is too much, just empty the stack completely
			item_slots[index].empty_stack()
		return true
	else:
		# nothing happend
		return false

# attempts to remove an entire dictionary of items
# if one of the items wasn't removed
# return false.
# the other items will be removed though, so be crafeull while using this!
func remove_dictionary(dict):
	var succeed = true
	for k in dict.keys():
		var a = remove_item(k, dict[k])
		if !a:
			succeed = false
	return succeed

# merge the stacks in the inventory, so seperated stacks now merge together.
# note this won't sort the items by name or anything
#
# how its done - jusr re-insert all the stacks with auto_sort on
func merge_inventory_stacks():
	# first duplicate all the current stacks into a new array:
	var slots_dupe = item_slots.duplicate()
	
	# empty the inventory:
	empty_inventory()
	
	for s in slots_dupe:
		if !s.is_empty():
			add_item(s.get_item_id(), s.get_amount())

func print_inventory():
	for s in item_slots:
		print(s)
