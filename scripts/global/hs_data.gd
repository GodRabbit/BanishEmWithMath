extends Node

# copyright 2021,2022 Dor "GodRabbit" Shlush
# this file is part of "BanishEmWithMath"

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.


# a a global class for "high score" (Honourable sacrifices) entries and data
# holds the top 5 of the player's times.
# Later add support for saving those to file

# NOTE: We don't differentiate between difficulties in the top score
# because harder difficulties ARE faster and we want to encourage players to use them
# to get better scores.
 
var hs_dict = {"zone1":[]}

# try to add a score <h> to the entries
# if the score is too low, discard it.
func add_score(h : hs_entry):
	var zone = h.get_zone()
	
	# get the entries for this zone, and duplicate it:
	var entries = hs_dict[zone].duplicate()
	
	if entries.size() == 0: # if the entries are 0, add the current hs
		entries.append(h)
		hs_dict[zone] = entries
		return
	
	var is_full = entries.size() == 5
	
	var found = false # flag for finding the correct spot
	for i in range(0, entries.size()):
		# is the time greater than the current tested? put it after it
		if h.compare(entries[i].get_time()) <= 0 and !found:
			found = true
			entries.insert(i, h)
	
	# if not found a time, and the entries are not full, append th score at the end
	if !found and !is_full:
		entries.append(h)
	
	# if the array now has more than 5 elements, destroy them:
	if entries.size() > 5:
		for i in range(5, entries.size()):
			entries.remove(i)
	
	hs_dict[zone] = entries

func get_score(zone, index):
	var entries = hs_dict[zone]
	if index < entries.size():
		return entries[index]
	else:
		return false

func get_entries_size(zone):
	return hs_dict[zone].size()

func log_print_hs(zone):
	var entries = hs_dict[zone]
	for i in range(0, entries.size()):
		Log.log_print(str(entries[i]))
