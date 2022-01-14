extends Control

# copyright 2021,2022 Dor "GodRabbit" Shlush
# this file is part of "BanishEmWithMath"

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

# a control class that collects data on sites and bosses and shows it to the programmer
#  Finds enemies that are gem\star outliers.

# nodes:
onready var text_label = $main_container/scroll_container/text_container/text_label
onready var exit_button = $main_container/exit_button

func _ready():
	clear_lines()
	# signals
	exit_button.connect("pressed", self, "on_exit_button_pressed")
	
	display_zone1_analyzis()

# add line to the label
func add_line(line):
	var s = text_label.text
	s += str(line) +"\n"
	text_label.text = s

func display_dictionary(d : Dictionary):
	for k in d:
		add_line(k+": "+ str(d[k]))

func clear_lines():
	text_label.text = ""

func display_zone1_analyzis():
	display_dictionary(enemies_data.get_zone_by_id("zone1"))
	add_line("")
	display_dictionary(analyze_boss_drops("galactic_cake"))
	add_line("")
	display_dictionary(analyze_boss_drops("sleeping_count"))
	add_line("")
	display_dictionary(analyze_boss_drops("schnoop_queen"))
	add_line("")
	
	add_line("Sites:")
	
	add_line("")
	add_line("Farm:")
	display_dictionary(analyze_site_gems("farm"))
	
	add_line("")
	add_line("Ocean:")
	display_dictionary(analyze_site_gems("ocean"))
	
	add_line("")
	add_line("jungle:")
	display_dictionary(analyze_site_gems("jungle"))
	
	add_line("")
	add_line("snowy_mountain:")
	display_dictionary(analyze_site_gems("snowy_mountain"))
	
	add_line("")
	add_line("fairy_swamp:")
	display_dictionary(analyze_site_gems("fairy_swamp"))
	
	add_line("")
	var f = order_site_enemies_gems("ocean")
	add_line("ocean:")
	add_line(f)
	
	add_line("")
	f = order_site_enemies_gems("jungle")
	add_line("jungle:")
	add_line(f)
	
	add_line("")
	f = order_site_enemies_gems("snowy_mountain")
	add_line("snowy_mountain:")
	add_line(f)
	
	add_line("")
	f = order_site_enemies_gems("fairy_swamp")
	add_line("fairy_swamp:")
	add_line(f)

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

# change name as this is going to be full analayze gems + stars
# returns a dictionary with the following data:
# "avg_stars_per_enemy": (how much stars each enemy give, on average (depending on weight))
# "max_enemy_stars":[<enemy_id>, value]
# "min_enemy_stars":[<enemy_id>, value]
# "avg_wave_stars": (how many stars you get per wave (average))
# "avg_enemies_for_death" (how many enemies should die to kill this boss, on average)
# How much stars each boss give? thats just its HP...
# "max_enemy_gems":[<enemy_id>, value]
# "min_enemy_gems":[<enemy_id>, value]
# "avg_gems_per_enemy": (how much stars each enemy give, on average (depending on weight))
# "total_gem_gain": (how many gems we expect to get on average after the boss is ded)
func analyze_boss_drops(boss_id):
	var enemies = enemies_data.get_enemies_by_boss(boss_id)
	var max_enemy_stars = []
	var min_enemy_stars = []
	
	var max_enemy_gems = []
	var min_enemy_gems = []
	
	# the first enemy for min\max purposes:
	var e = enemies_data.get_enemy_by_id(enemies.keys()[0])
	var stars = e.get_stars()
	var gems = get_enemy_total_gem_drops(e)
	
	# min\max stars:
	max_enemy_stars = [enemies.keys()[0], stars]
	min_enemy_stars = [enemies.keys()[0], stars]
	
	# min\max gems:
	max_enemy_gems = [enemies.keys()[0], gems]
	min_enemy_gems = [enemies.keys()[0], gems]
	
	var sum_stars = 0 # how many total stars the enemies give
	var sum_gems = 0 # how many gems the enemy give
	var count = 0 # how many enemies by enemy weight
	for e_id in enemies.keys():
		# get the actual enemy: (enemy_abstract)
		e = enemies_data.get_enemy_by_id(e_id)
		
		# how much stars this enemy drops? 
		stars = e.get_stars() 
		
		# how much total gems this enemy drops?
		gems = get_enemy_total_gem_drops(e)
		
		# for the average stars calculation
		sum_stars += stars * enemies[e_id] # we multiply by weight to get a correct average
		sum_gems += gems * enemies[e_id] # we multiply by weight to get a correct average 
		count += enemies[e_id] # enemy weight
		
		# greater than the current max?
		if stars > max_enemy_stars[1]:
			max_enemy_stars = [e_id, stars]
		
		# lower than the current min?
		if stars < min_enemy_stars[1]:
			min_enemy_stars = [e_id, stars]
		
		# greater than the current max?
		if gems > max_enemy_gems[1]:
			max_enemy_gems = [e_id, gems]
		
		# lower than the current min?
		if gems < min_enemy_gems[1]:
			min_enemy_gems = [e_id, gems]
	
	var avg_stars_per_enemy = float(sum_stars)/float(count)
	
	var d = {}
	
	# stars:
	d["max_enemy_stars"] = max_enemy_stars
	d["min_enemy_stars"] = min_enemy_stars
	d["avg_stars_per_enemy"] = avg_stars_per_enemy
	
	var boss_hp = enemies_data.get_boss_by_id(boss_id)["hp"]
	var wave_size = enemies_data.get_boss_by_id(boss_id)["wave_size"]
	var average_wave_size = float(wave_size[1] + wave_size[0])/2.0
	d["avg_enemies_for_death"] = float(boss_hp) / avg_stars_per_enemy
	d["avg_wave_stars"] = average_wave_size * avg_stars_per_enemy
	d["boss_hp"] = boss_hp
	
	# gems:
	var avg_gems_per_enemy = float(sum_gems)/float(count)
	d["max_enemy_gems"] = max_enemy_gems
	d["min_enemy_gems"] = min_enemy_gems
	d["avg_gems_per_enemy"] = avg_gems_per_enemy
	d["total_gem_gain"] = avg_gems_per_enemy * d["avg_enemies_for_death"]
	return d
	

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

func on_exit_button_pressed():
	get_tree().quit()
