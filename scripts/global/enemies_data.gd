extends Node

# copyright 2021,2022 Dor "GodRabbit" Shlush
# this file is part of "BanishEmWithMath"

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

# a global class the holds all the enemies data.
# each enemy must be registered and added to this class.

var enemies_collection = []

var sites = {
"farm":
	{"enemies":["angry_pear", "applady", "wheaty", "sad_eggy", "schnoop",
	"leafonger", "sneaky_cheese"],
	"backgrounds":["farm_day", "farm_morning", "farm_night", "farm_sunset"],
	"price":0,
	"name":"Farm",
	"music":"magic-2072"},
"jungle":
	{"enemies":["spikey_boi", "boo_da_rang", "grape_moment", "spider", "mossy_boo_da_rang",
	"karen_melon", "jungle_schnoop", "hornet", "cool_banana", "man_go", "jungle_snail"],
	"backgrounds":["jungle1"],
	"price":30,
	"name":"Jungle",
	"music":"fluidity-100-ig-edit-4558"},
"ocean":
	{"enemies":["cra_babi", "boo_da_rang", "flying_fish",
	"beach_ball","water_schnoop", "water_snail","karen_melon", "clamp", "jellofish"],
	"backgrounds":["ocean1", "ocean2"],
	"price":25,
	"name":"Ocean",
	"music":"geovane-bruno-drone-in-the-ocean-3593"},
"cemetery":
	{"enemies":["spider", "delilah", "jacko"],
	"backgrounds":["cemetery1"],
	"price":50,
	"name":"Cemetery",
	"music":""},
"the_white_board":
	{"enemies":["plusumad", "demultiply", "diversary"],
	"backgrounds":["white_board"],
	"price":75,
	"name":"The White Board",
	"music":""},
"fairy_swamp":
	{
	"enemies":["punguy", "grandhamster", "goodbi", "fairy_schnoop", "butter_fly",
	"fairy", "fairy_owllo", "dark_owllo", "snail_wizard", "dark_cheese"],
	"backgrounds":["fairy_swamp"],
	"price":75,
	"name":"Fairy Swamp",
	"music":"heavy-1297"
	},
"snowy_mountain":
	{
	"enemies":["snowperson", "snowy_cra_babi", "pain_tree", "snowy_spider", "cursed_queen",
	"not_a_snake", "snowy_schnoop", "owllo"],
	"backgrounds":["snowy_mountain"],
	"price":75,
	"name":"Snowy Forest",
	"music":"snow-tornado-7813"
	}
}

var zones = {
	"zone0":{
		"id":"zone0",
		"name":"Zone 0",
		"ages":[5, 7],
		"sites":{
			
		},
		"bosses":{
			
		},
		"final_boss":""
		
	},
	"zone1":{
		"id":"zone1",
		"name":"Zone 1",
		"ages":[8, 12],
		"sites":{
			"farm":{},
			"ocean":{"money":20},  #, "apple":3, "pear":2},
			"jungle":{"money":35},
			"snowy_mountain":{"money":100},
			"fairy_swamp":{"money":125}
		},
		"bosses":{
			"galactic_cake":{"stars":50},
			"sleeping_count":{"stars":150},
			"schnoop_queen":{"stars":300}
		},
		"final_boss":"schnoop_queen",
		"new_game":[
			{
				"sites":{
					"farm":{},
					"ocean":{"money":20}, 
					"jungle":{"money":45},
					"snowy_mountain":{"money":150},
					"fairy_swamp":{"money":175},
					"cemetery":{"money":230}
				},
				"bosses":{
					"galactic_cake":{"stars":60},
					"sleeping_count":{"stars":170},
					"schnoop_queen":{"stars":330}
				},
				"final_boss":"schnoop_queen"
			}
		]
	}
}

var bosses = {
	"galactic_cake":{
		"id":"galactic_cake",
		"name":"Galactic Cake",
		"hp":55,
		"background":"background_space",
		"enemies":{ # a dictionary of enemy id and the weight of the enemy
			"disturbing_star":90,
			"doom_cupcake":90,
			"piece_of_cake":90,
			"chocolate_meteor":70
		},
		"wave_size":[2, 4],
		"music":"cardio-166bpm-b-min-4110"
	},
	"sleeping_count":{
		"id":"sleeping_count",
		"name":"Sleeping Count",
		"hp":90,
		"background":"background_the_stage",
		"enemies":{ # a dictionary of enemy id and the weight of the enemy
			"sleepy_bear":10,
			"nightmare":10,
			"daydream":10,
			"mr_pillowman":2
		},
		"wave_size":[2, 4],
		"music":"house-fashion-5000"
	},
	"schnoop_queen":{
		"id":"schnoop_queen",
		"name":"Schnoop Queen",
		"hp":150, 
		"background":"background_schnoop_queen",
		"enemies":{ # a dictionary of enemy id and the weight of the enemy
			"schnoop":5,
			"fairy_schnoop":5,
			"snowy_schnoop":5,
			"water_schnoop":5,
			"jungle_schnoop":5,
			"count_schnoop":10,
			"undead_schnoop":10,
			"fiery_schnoop":10,
			"isnaid_schnoop":10
		},
		"wave_size":[3, 5],
		"music":"perfect-dark170-fmin-4390"
	},
	"debug_test":{
		"id":"debug_test",
		"name":"Galactic Cake",
		"hp":30,
		"background":"background_test",
		"enemies":{ # a dictionary of enemy id and the weight of the enemy
			"disturbing_star":90,
			"doom_cupcake":90,
			"piece_of_cake":90,
			"chocolate_meteor":70
		},
		"wave_size":[2, 4],
		"music":""
	}
}


# Called when the node enters the scene tree for the first time.
func _ready():
	# can this be jsoned??
	_add_enemy(enemy_abstract.new("spider", # id
	"Spider", # name
	puzzle_minmax_subtraction.new(50), # puzzle
	30, # time
	7, # stars
	1, # damage
	{"spider_leg":1, "spider_eye":1}))
	
	# tutorial enemy
	_add_enemy(enemy_abstract.new("tutorial_schnoop",
	"Hatched Schnoop",
	puzzle_addition.new(0, 5),
	40,
	5,
	1,
	{"apple":15, "pear":15, "ghost_hair":2}))
	
	# farm enemy
	_add_enemy(enemy_abstract.new("angry_pear",
	"Angry Pear",
	puzzle_addition.new(0, 10),
	30,
	1,
	1,
	{"pear":1}))
	
	# farm enemy
	_add_enemy(enemy_abstract.new("angry_apple",
	"Angry Apple",
	puzzle_subtraction.new(),
	30,
	3,
	1,
	{"apple":2}))
	
	# farm enemy
	_add_enemy(enemy_abstract.new("wheaty",
	"Wheaty",
	puzzle_addition.new(0, 50),
	60,
	3,
	1,
	{"wheat":2}))
	
	# farm enemy
	_add_enemy(enemy_abstract.new("sad_eggy",
	"Sad Eggy",
	puzzle_subtraction.new(20),
	60,
	3,
	1,
	{"egg":1}))
	
	# farm enemy
	_add_enemy(enemy_abstract.new("sneaky_cheese", 
	"Sneaky Cheese",
	puzzle_minmax_basic.new(100),
	20,
	1,
	1,
	{"cheese":1})) 
	
	# jungle enemy
	_add_enemy(enemy_abstract.new("spikey_boi",
	"Spikey Boi",
	puzzle_prime_detection.new(50),
	30,
	5,
	2,
	{"spike":2}))
	
	# jungle enemy
	_add_enemy(enemy_abstract.new("grape_moment",
	"Grape Moment",
	puzzle_multi_simple.new(1, 15),
	50,
	5,
	1,
	{"grape":3}))
	
	# ocean enemy
	_add_enemy(enemy_abstract.new("cra_babi",
	"Cra Babi",
	puzzle_multi_simple.new(0, 5),
	30,
	3,
	1,
	{"spider_eye":1, "spike":1}))
	
	# ocean enemy
	_add_enemy(enemy_abstract.new("beach_ball",
	"Beach Ball", # TODO: change name
	puzzle_prime_detection.new(20, true),
	30,
	3,
	1,
	{"glass_shard":1})) #TODO: change?
	
	# ocean\jungle enemy
	_add_enemy(enemy_abstract.new("boo_da_rang",
	"Boo Da Rang",
	puzzle_addition_blank.new(0, 20),
	30,
	4,
	1,
	{"moss_ball":1})) 
	
	# jungle enemy
	_add_enemy(enemy_abstract.new("mossy_boo_da_rang", 
	"Mossy Boo Da Rang",
	puzzle_addition_blank.new(0, 40),
	20,
	5,
	1,
	{"moss_ball":2})) 
	
	# ocean enemy
	_add_enemy(enemy_abstract.new("flying_fish", 
	"Flying Fish", # TODO: change name
	puzzle_addition.new(10, 100),
	30,
	3,
	2,
	{"dragon_scale":1})) 
	
	# ocean enemy
	_add_enemy(enemy_abstract.new("water_schnoop",
	"Water Schnoop",
	puzzle_subtraction.new(50),
	30,
	4,
	1,
	{"ghost_hair":2, "glass_shard":1}))
	
	# ocean enemy
	_add_enemy(enemy_abstract.new("clamp", 
	"Clamp", #TODO: change name?
	puzzle_addition_compound.new(10, 50),
	60,
	6,
	1,
	{"glass_shard":1, "pearl":1})) 
	
	# ocean enemy
	_add_enemy(enemy_abstract.new("water_snail",
	"Water Snail", #TODO: change name!
	puzzle_arithmetic_sequence.new(0, 20, 0, 10, true), 
	20,
	6,
	2,
	{"shell":1})) 
	
	# ocean\jungle enemy
	_add_enemy(enemy_abstract.new("karen_melon",
	"Karen Melon", 
	puzzle_arithmetic_sequence.new(0, 60, -10, 0, true), 
	20,
	7,
	2,
	{"watermelon":1}))
	
	# ocean enemy
	_add_enemy(enemy_abstract.new("jellofish", 
	"JelloFish", 
	puzzle_minmax_addition.new(100), 
	50,
	7,
	1,
	{"jelly":1}))
	
	# jungle enemy
	_add_enemy(enemy_abstract.new("jungle_schnoop", 
	"Jungle Schnoop", 
	puzzle_subtraction.new(200), 
	20,
	5,
	2,
	{"ghost_hair":2, "moss_ball":1}))
	
	# jungle enemy
	_add_enemy(enemy_abstract.new("hornet", 
	"Hornet", # TODO: change name
	puzzle_addition_compound.new(10, 100),
	40,
	7,
	1,
	{"spike":2, "egg":1})) 
	
	# jungle enemy
	_add_enemy(enemy_abstract.new("cool_banana", 
	"Cool Banana!", # TODO: change name?
	puzzle_subtraction_compound.new(5, 50, true), 
	40,
	7,
	1,
	{"banana":1})) 
	
	# jungle enemy
	_add_enemy(enemy_abstract.new("man_go", 
	"Man gO!", # TODO: change name?
	puzzle_subtraction_blank.new(2, 20),
	40,
	7,
	1,
	{"mango":1}))
	
	# jungle enemy
	_add_enemy(enemy_abstract.new("jungle_snail", 
	"Jungle Snail", 
	puzzle_arithmetic_sequence.new(0, 50, 0, 15, true),
	20,
	6,
	3,
	{"shell":1, "moss_ball":1})) 
	
	# cemetery enemy
	_add_enemy(enemy_abstract.new("jacko",
	"Jacko",
	puzzle_fractions_division.new(10),
	25,
	12,
	2,
	{"pumpkin":2, "ghost_hair":3}))
	
	# cemetery enemy
	_add_enemy(enemy_abstract.new("delilah",
	"Delilah",
	puzzle_fractions_multi.new(10),
	20,
	7,
	2,
	{"ghost_hair":4, "apple":1}))
	
	# cemetery enemy
	_add_enemy(enemy_abstract.new("master_bat", 
	"Master Bat", 
	puzzle_arithmetic_order.new(),
	20,
	8,
	2,
	{"bat_wing":3})) # maybe make certain items do some effects? turning you into vampire?
	
	# cemetery enemy
	_add_enemy(enemy_abstract.new("digger_schnoop", 
	"digger_schnoop", 
	puzzle_prime_detection.new(150, false),
	30,
	10,
	3,
	{"ghost_hair":12}))
	
	# cemetery enemy
	_add_enemy(enemy_abstract.new("dark_snail_wizard", 
	"dark_snail_wizard", 
	puzzle_percentages_to_fractions.new(),
	25,
	7,
	1,
	{"shell":3, "ghost_hair":2}))
	
	# 
	_add_enemy(enemy_abstract.new("plusumad",
	"Plusumad",
	puzzle_addition_negatives.new(100),
	10,
	10,
	2,
	{"math_soul":1}))
	
	# 
	_add_enemy(enemy_abstract.new("demultiply",
	"Demultiply",
	puzzle_multi_negatives.new(),
	10,
	10,
	2,
	{"math_soul":2}))
	
	# 
	_add_enemy(enemy_abstract.new("diversary",
	"Diversary",
	puzzle_division.new(),
	10,
	10,
	2,
	{"math_soul":2}))
	
	# galactic cake enemy
	_add_enemy(enemy_abstract.new("disturbing_star",
	"Disturbing Star",
	puzzle_addition_compound.new(10, 150),
	40,
	5,
	1,
	{"star_piece":1}))
	
	# galactic cake enemy
	_add_enemy(enemy_abstract.new("piece_of_cake", 
	"Piece of Cake",
	puzzle_subtraction_compound.new(5, 100, true),
	40,
	7,
	1,
	{"cake_piece":1}))
	
	# galactic cake enemy
	_add_enemy(enemy_abstract.new("doom_cupcake",
	"Doom Cupcake",
	puzzle_addition_blank.new(0, 100),
	20,
	5,
	1,
	{"cake_piece":1}))
	
	# galactic cake enemy
	_add_enemy(enemy_abstract.new("chocolate_meteor",
	"chocolate_meteor",
	puzzle_subtraction_blank.new(0, 100),
	40,
	5,
	1,
	{"cake_piece":1})) # TODO: change?
	
	# farm enemy
	_add_enemy(enemy_abstract.new("applady",
	"Applady",
	puzzle_even_odd.new(20),
	20,
	1,
	1,
	{"apple":1}))
	
	# farm enemy
	_add_enemy(enemy_abstract.new("leafonger",
	"Leafonger",
	puzzle_addition_compound.new(5, 20),
	60,
	5,
	1,
	{"leaf":1}))
	
	# farm enemy
	_add_enemy(enemy_abstract.new("schnoop",
	"Schnoop",
	puzzle_subtraction.new(50),
	40,
	3,
	1,
	{"ghost_hair":1}))
	
	# snow enemies:
	_add_enemy(enemy_abstract.new("snowperson", 
	"SnowPerson",
	puzzle_division_simple.new(11),
	60,
	4,
	1,
	{"snowball":3})) 
	
	_add_enemy(enemy_abstract.new("snowy_cra_babi", 
	"Snowy Cra Babi",
	puzzle_multi_simple.new(5, 15),
	30,
	5,
	1,
	{"spider_eye":2, "pearl":1})) # TODO: change?
	
	_add_enemy(enemy_abstract.new("pain_tree", 
	"Pain Tree",
	puzzle_multi_compound.new(2, 10),
	40,
	6,
	1,
	{"leaf":5})) # TODO: change?
	
	_add_enemy(enemy_abstract.new("snowy_spider", 
	"Snowy Spider",
	puzzle_minmax_multi.new(10),
	50,
	8,
	1,
	{"spider_leg":2, "spider_eye":2}))
	
	_add_enemy(enemy_abstract.new("cursed_queen", 
	"Cursed Queen",
	puzzle_addition_compound.new(10, 200),
	30,
	6,
	2,
	{"ghost_hair":4}))
	
	_add_enemy(enemy_abstract.new("not_a_snake", 
	"Not a Snake",
	puzzle_prime_detection.new(130, false),
	45,
	6,
	2,
	{"ghost_hair":4, "snowball":2}))
	
	_add_enemy(enemy_abstract.new("snowy_schnoop",
	"Snowy Schnoop",
	puzzle_subtraction_compound.new(15, 150, true),
	40,
	8,
	2,
	{"ghost_hair":5, "snowball":4}))
	
	_add_enemy(enemy_abstract.new("owllo", 
	"Owllo",
	puzzle_multi_blank.new(1, 15),
	40,
	6,
	2,
	{"ghost_hair":3, "snowball":2})) # TODO: change to feather?
	
	# fairy swamp enemies:
	_add_enemy(enemy_abstract.new("goodbi", 
	"GoodBi", # TODO: change?
	puzzle_fractions_addition.new(5),
	40,
	10,
	1,
	{"jelly":3})) 
	
	_add_enemy(enemy_abstract.new("punguy", 
	"Punguy", 
	puzzle_division_simple.new(10),
	40,
	7,
	1,
	{"mushroom":1})) 
	
	_add_enemy(enemy_abstract.new("grandhamster", 
	"GrandHamster", 
	puzzle_division.new(11, 11),
	45,
	8,
	1,
	{"pearl":1, "fairy_dust":1})) # TODO: change? (maybe to chess queen piece?)
	
	_add_enemy(enemy_abstract.new("fairy_schnoop", 
	"Fairy Schnoop", 
	puzzle_addition_ultimate_easy.new(3, 95, true),
	50,
	8,
	2,
	{"ghost_hair":2, "fairy_dust":1})) 
	
	_add_enemy(enemy_abstract.new("butter_fly", 
	"Butter Fly", 
	puzzle_fractions_simplify.new(10, 10),
	25,
	8,
	2,
	{"fairy_dust":1})) # TODO: change?
	
	_add_enemy(enemy_abstract.new("fairy", 
	"Fairy", 
	puzzle_prime_detection.new(130, false),
	25,
	10,
	2,
	{"fairy_dust":2})) # TODO: change?
	
	_add_enemy(enemy_abstract.new("fairy_owllo", 
	"Fairy Owllo", 
	puzzle_multi_blank.new(3, 20),
	25,
	7,
	2,
	{"fairy_dust":2}))  # TODO: change?
	
	# fairy swamp\cemetery enemy
	_add_enemy(enemy_abstract.new("dark_owllo", 
	"Dark Owllo", 
	puzzle_division_blank.new(1, 10),
	30,
	8,
	2,
	{"ghost_hair":4, "fairy_dust":1}))  # TODO: change?
	
	_add_enemy(enemy_abstract.new("snail_wizard", 
	"Snail Wizard", 
	puzzle_arithmetic_sequence.new(10, 70, -20, 20, true),
	20,
	8,
	4,
	{"shell":2, "fairy_dust":1})) 
	
	_add_enemy(enemy_abstract.new("dark_cheese", 
	"Dark Cheese", 
	puzzle_minmax_division.new(10),
	45,
	8,
	1,
	{"cheese":5}))
	
	# sleeping count enemies:
	_add_enemy(enemy_abstract.new("sleepy_bear",
	"Sleepy Bear", 
	puzzle_division.new(10, 10),
	35,
	7,
	1,
	{"sleep_essence":3})) # TODO: change?
	
	_add_enemy(enemy_abstract.new("nightmare", 
	"Nightmare", 
	puzzle_division_blank.new(1, 10),
	45,
	7,
	1,
	{"ghost_hair":1, "sleep_essence":3}))  
	
	_add_enemy(enemy_abstract.new("daydream", 
	"Daydream", 
	puzzle_multi_blank.new(1, 15),
	30,
	7,
	1,
	{"ghost_hair":1, "sleep_essence":3}))  
	
	_add_enemy(enemy_abstract.new("mr_pillowman", 
	"Mr. pillowman", 
	puzzle_arithmetic_order.new(),
	55,
	10,
	1,
	{"ghost_hair":2, "sleep_essence":5})) # TODO: change? (maybe moustache?)
	
	# schnoop Queen Enemies:
	_add_enemy(enemy_abstract.new("count_schnoop", 
	"count_schnoop", 
	puzzle_arithmetic_order.new(),
	20,
	10,
	3,
	{"ghost_hair":10})) # TODO: change?
	
	# also cemetery enemy
	_add_enemy(enemy_abstract.new("undead_schnoop", 
	"undead_schnoop", 
	puzzle_fractions_addition.new(10),
	35,
	12,
	2,
	{"ghost_hair":12}))
	
	
	
	_add_enemy(enemy_abstract.new("fiery_schnoop", 
	"fiery_schnoop", 
	puzzle_minmax_subtraction.new(150),
	25,
	12,
	2,
	{"ghost_hair":12}))
	
	_add_enemy(enemy_abstract.new("isnaid_schnoop", 
	"isnaid_schnoop", 
	puzzle_minmax_fractions.new(15, false, 1.0),
	45,
	12,
	2,
	{"ghost_hair":12}))
	
	# advanced enemies:
	_add_enemy(enemy_abstract.new("infused_schnoop", 
	"Infused Schnoop", 
	puzzle_powers_two.new(),
	20,
	1,
	1,
	{"ghost_hair":2}))



func _add_enemy(e : enemy_abstract):
	enemies_collection.append(e)

func get_enemy_by_index(i):
	return enemies_collection[i]

func get_enemy_by_id(id):
	for e in enemies_collection:
		if e.get_enemy_id() == id:
			return e
	return null

# todo: add blacklist option
func get_random_enemy() -> enemy_abstract:
	randomize()
	var index = randi() % enemies_collection.size()
	return enemies_collection[index]

# returns an array with random unique sites
# the size of the result array is min(amount, <how many sites are not in the blacklist>)
func get_random_site(amount = 1, blacklist = []) -> Array:
	var sites_dupe = sites.keys().duplicate()
	
	# remove the sites that are blacklisted:
	for b in blacklist:
		if sites_dupe.has(b):
			sites_dupe.erase(b)
	
	var result = []
	
	var m = sites_dupe.size()
	for i in range(0, int(min(amount, m))):
		# get a random index:
		randomize()
		var index = randi() % sites_dupe.size()
		
		# add the random value to result:
		result.append(sites_dupe[index])
		
		# remove the added value so it won't repeat
		sites_dupe.remove(index)
	
	return result

# returns the array of enemies of this site_id
func get_enemies_by_site(site_id) -> Array:
	if sites.has(site_id):
		return sites[site_id]["enemies"]
	else:
		return []

# return a random background id from the <site_id> given
func get_background_id_by_site(site_id):
	var a = sites[site_id]["backgrounds"]
	if a.size() <= 0:
		return "overworld" # default background
	elif a.size() == 1:
		return a[0]
	else:
		randomize()
		var index = randi() % a.size()
		return a[index]

func get_site_name(site_id):
	return sites[site_id]["name"]

func get_sites_ids(zone_id, new_game = 0):
	if new_game == 0:
		return zones[zone_id]["sites"].keys()
	else:
		# find the site in the new game field
		# if the current new game is larger than the last data on new games just take the 
		# largest
		var new_game_data = zones[zone_id]["new_game"] # an array
		var index = int(min(new_game_data.size(), new_game))
		index = index - 1 # the index of the relevant new game
		
		return new_game_data[index]["sites"].keys()

func get_bosses_ids(zone_id, new_game = 0):
	if new_game == 0:
		return zones[zone_id]["bosses"].keys()
	else:
		# find the site in the new game field
		# if the current new game is larger than the last data on new games just take the 
		# largest
		var new_game_data = zones[zone_id]["new_game"] # an array
		var index = int(min(new_game_data.size(), new_game))
		index = index - 1 # the index of the relevant new game
		
		return new_game_data[index]["bosses"].keys()


# <new_game> is how many cycles the player completed of the game
func get_site_price(zone_id, site_id, new_game = 0):
	if new_game == 0:
		return zones[zone_id]["sites"][site_id]
	else:
		# find the site in the new game field
		# if the current new game is larger than the last data on new games just take the 
		# largest
		var new_game_data = zones[zone_id]["new_game"] # an array
		var index = int(min(new_game_data.size(), new_game))
		index = index - 1 # the index of the relevant new game
		
		return new_game_data[index]["sites"][site_id]

# <new_game> is how many cycles the player completed of the game
func get_boss_star_price(zone_id, boss_id, new_game = 0):
	if new_game == 0:
		return zones[zone_id]["bosses"][boss_id]["stars"]
	else:
		# find the boss in the new game field
		# if the current new game is larger than the last data on new games just take the 
		# largest
		var new_game_data = zones[zone_id]["new_game"] # an array
		var index = int(min(new_game_data.size(), new_game))
		index = index - 1 # the index of the relevant new game
		
		return new_game_data[index]["bosses"][boss_id]["stars"]

# is the boss_id the final boss in zone <zone_id>, while on new game cycle <new_game>
func is_final_boss(zone_id, boss_id, new_game = 0):
	if new_game == 0:
		var final_id = zones[zone_id]["final_boss"]
		return final_id == boss_id
	else:
		var new_game_data = zones[zone_id]["new_game"] # an array
		var index = int(min(new_game_data.size(), new_game))
		index = index - 1
		
		var final_id = new_game_data[index]["final_boss"]
		return final_id == boss_id


func get_boss_by_id(boss_id):
	return bosses[boss_id]

# plz note that these are dictionaries with weights and not 
# an array
func get_enemies_by_boss(boss_id):
	return get_boss_by_id(boss_id)["enemies"]

func get_boss_music(boss_id):
	return bosses[boss_id]["music"]

func get_site_music(site_id):
	return sites[site_id]["music"]

func get_zone_by_id(zone_id):
	return zones[zone_id]


