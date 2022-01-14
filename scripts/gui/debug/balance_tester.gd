extends Control

# copyright 2021,2022 Dor "GodRabbit" Shlush
# this file is part of "BanishEmWithMath"

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

# a control class that collects data on sites and bosses and shows it to the programmer
#  Finds enemies that are gem\star outliers.

func _ready():
	var g = analyze_site_gems("farm")
	Log.log_print("Farm: " + str(g))
	
	g = analyze_site_gems("ocean")
	Log.log_print("ocean: " + str(g))
	
	g = analyze_site_gems("jungle")
	Log.log_print("jungle: " + str(g))
	
	g = analyze_site_gems("snowy_mountain")
	Log.log_print("snowy_mountain: " + str(g))
	
	g = analyze_site_gems("fairy_swamp")
	Log.log_print("fairy_swamp: " + str(g))
	
	var f = order_site_enemies_gems("ocean")
	print("ocean:")
	print(f)
	
	f = order_site_enemies_gems("jungle")
	print("jungle:")
	print(f)
	
	f = order_site_enemies_gems("snowy_mountain")
	print("snowy_mountain:")
	print(f)

# returns the average of the enemy's gem drops according to item prices
func get_enemy_average_gem_drops(e : enemy_abstract):
	var items = e.get_items()
	return items_data.get_average_gems(items)

# returns the total of the enemy's gem drops according to item prices
func get_enemy_total_gem_drops(e : enemy_abstract):
	var items = e.get_items()
	return items_data.get_total_gems(items)

# returns a site's average gems of all the enemies in the site
func get_site_average_gem(site_id) -> float:
	var enemies = enemies_data.get_enemies_by_site(site_id)
	
	var sum = 0
	for e_id in enemies:
		var e = enemies_data.get_enemy_by_id(e_id)
		sum += get_enemy_total_gem_drops(e)
	return float(sum)/float(enemies.size())

# return a dictionary with the data
# "max_enemy_gems":[<enemy_id>, <amount>]
# "min_enemy_gems":[<enemy_id>, <amount>]
# "avg_gems":<average gems of the site>
func analyze_site_gems(site_id) -> Dictionary:
	var max_enemy_gems = []
	var min_enemy_gems = []
	var sum_gems = 0
	
	var enemies = enemies_data.get_enemies_by_site(site_id)
	var sum = 0
	
	# do the for loop for the first element
	#  (for the min\max purposes, don't do the sum, 
	#  otherwise you'll br repeat counting the first elements)
	var e = enemies_data.get_enemy_by_id(enemies[0])
	var gems = get_enemy_total_gem_drops(e)
	max_enemy_gems = [enemies[0], gems]
	min_enemy_gems = [enemies[0], gems]
	
	for e_id in enemies:
		# gets the actual enemy:
		e = enemies_data.get_enemy_by_id(e_id)
		
		# total gems dropped by this enemy:
		gems = get_enemy_total_gem_drops(e)
		
		# this is an outlier? (max)
		if gems > max_enemy_gems[1]:
			max_enemy_gems = [e_id, gems]
		
		# this is an outlier? (min)
		if gems < min_enemy_gems[1]:
			min_enemy_gems = [e_id, gems]
		
		sum += gems
	var d = {}
	d["max_enemy_gems"] = max_enemy_gems
	d["min_enemy_gems"] = min_enemy_gems
	d["avg_gems"] = float(sum)/float(enemies.size())
	return d

func analyze_boss_stars(boss_id):
	pass

# gets a site_id and return an array of 2 valued arrays
# [[<enemy_id0>, <amount0>], [<enemy_id1>, <amount1>], ...]
# such that the enemies ids are for enemies in this site and 
# the amounts are increasing
func order_site_enemies_gems(site_id):
	var enemies = enemies_data.get_enemies_by_site(site_id).duplicate()
	var result = []
	
	# do the for loop for the first enemy
	# gets the actual enemy:
	var e = enemies_data.get_enemy_by_id(enemies[0])
		
	# total gems dropped by this enemy:
	var gems = get_enemy_total_gem_drops(e)
	
	result.append([enemies[0], gems])
	
	# remove the first enemy, as we already inserted it
	enemies.remove(0)
	
	for e_id in enemies:
		# gets the actual enemy:
		e = enemies_data.get_enemy_by_id(e_id)
		
		# total gems dropped by this enemy:
		gems = get_enemy_total_gem_drops(e)
		
		# loop through the result to insert the current enemy in 
		# correct spot:
		var found = false
		for i in range(0, result.size()):
			if result[i][1] >= gems and !found:
				found = true
				result.insert(i, [e_id, gems])
		if !found:
			result.append([e_id, gems])
	return result


