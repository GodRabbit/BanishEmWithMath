extends Node


# a global class the holds all the enemies data.
# each enemy must be registered and added to this class.

var enemies_collection = []

var sites = {
"farm":
	{"enemies":["angry_pear", "applady", "wheaty", "sad_eggy", "schnoop","leafonger"],
	"backgrounds":["farm1"],
	"price":0,
	"name":"Farm"},
"jungle":
	{"enemies":["spikey_boi", "boo_da_rang", "grape_moment", "spider", "mossy_boo_da_rang",
	"karen_melon", "jungle_schnoop", "hornet", "cool_banana", "man_go", "jungle_snail"],
	"backgrounds":["jungle1"],
	"price":30,
	"name":"Jungle"},
"ocean":
	{"enemies":["cra_babi", "boo_da_rang", "flying_fish",
	"beach_ball","water_schnoop", "water_snail","karen_melon", "clamp"],
	"backgrounds":["ocean1", "ocean2"],
	"price":25,
	"name":"Ocean"},
"cemetery":
	{"enemies":["spider", "delilah", "jacko"],
	"backgrounds":["cemetery1"],
	"price":50,
	"name":"Cemetery"},
"the_white_board":
	{"enemies":["plusumad", "demultiply", "diversary"],
	"backgrounds":["white_board"],
	"price":75,
	"name":"The White Board"},
"fairy_swamp":
	{
	"enemies":["punguy", "grandhamster", "goodbi", "fairy_schnoop", "butter_fly",
	"fairy", "fairy_owllo", "dark_owllo", "snail_wizard"],
	"backgrounds":["fairy_swamp"],
	"price":75,
	"name":"Fairy Swamp"
	},
"snowy_mountain":
	{
	"enemies":["snowperson", "snowy_cra_babi", "pain_tree", "snowy_spider", "cursed_queen",
	"not_a_snake", "snowy_schnoop", "owllo"],
	"backgrounds":["snowy_mountain"],
	"price":75,
	"name":"Snowy Forest"
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
			
		}
		
	},
	"zone1":{
		"id":"zone1",
		"name":"Zone 1",
		"ages":[8, 12],
		"sites":{
			"farm":{},
			"ocean":{"money":20, "apple":3, "pear":2},
			"jungle":{"money":35},
			"snowy_mountain":{"money":100},
			"fairy_swamp":{"money":125}
		},
		"bosses":{
			"galactic_cake":{"stars":100}
		}
	}
}

var bosses = {
	"galactic_cake":{
		"id":"galactic_cake",
		"name":"Galactic Cake",
		"hp":150,
		"background":"background_space",
		"enemies":{ # a dictionary of enemy id and the weight of the enemy
			"disturbing_star":90,
			"doom_cupcake":90,
			"piece_of_cake":90,
			"chocolate_meteor":70
		},
		"wave_size":[2, 4],
		"final_enemy":"plusumad" # deprecate??
	}
}


# Called when the node enters the scene tree for the first time.
func _ready():
	# can this be jsoned??
	_add_enemy(enemy_abstract.new("spider", # id
	"Spider", # name
	puzzle_addition.new(100, 500), # puzzle
	20, # time
	5, # stars
	2, # damage
	{"spider_leg":1, "spider_eye":1})) 
	
	_add_enemy(enemy_abstract.new("angry_pear",
	"Angry Pear",
	puzzle_addition.new(0, 10),
	30,
	1,
	1,
	{"pear":1}))
	
	_add_enemy(enemy_abstract.new("angry_apple",
	"Angry Apple",
	puzzle_subtraction.new(),
	30,
	3,
	1,
	{"apple":2}))
	
	_add_enemy(enemy_abstract.new("wheaty",
	"Wheaty",
	puzzle_addition.new(0, 50),
	60,
	3,
	1,
	{"wheat":2}))
	
	_add_enemy(enemy_abstract.new("sad_eggy",
	"Sad Eggy",
	puzzle_subtraction.new(20),
	60,
	3,
	1,
	{"egg":1}))
	
	_add_enemy(enemy_abstract.new("spikey_boi",
	"Spikey Boi",
	puzzle_prime_detection.new(50),
	30,
	5,
	2,
	{"spike":1}))
	
	_add_enemy(enemy_abstract.new("grape_moment",
	"Grape Moment",
	puzzle_multi_simple.new(1, 15),
	50,
	5,
	1,
	{"grape":3}))
	
	_add_enemy(enemy_abstract.new("cra_babi",
	"Cra Babi",
	puzzle_multi_simple.new(0, 5),
	30,
	3,
	1,
	{"spider_eye":1, "spike":1}))
	
	_add_enemy(enemy_abstract.new("beach_ball",
	"Beach Ball", # TODO: change name
	puzzle_prime_detection.new(20, true),
	30,
	3,
	1,
	{"spider_eye":1, "spike":1})) #TODO: change
	
	_add_enemy(enemy_abstract.new("boo_da_rang",
	"Boo Da Rang",
	puzzle_addition_blank.new(0, 20),
	30,
	4,
	1,
	{"spider_eye":1, "spike":1, "apple":1, "egg":1})) # TODO: whats going on..?
	
	_add_enemy(enemy_abstract.new("mossy_boo_da_rang", 
	"Mossy Boo Da Rang",
	puzzle_addition_blank.new(0, 40),
	20,
	5,
	1,
	{"spider_eye":1, "spike":1, "apple":1, "egg":1})) # TODO: whats going on..?
	
	_add_enemy(enemy_abstract.new("flying_fish", 
	"Flying Fish", # TODO: change name
	puzzle_addition.new(10, 100),
	30,
	3,
	2,
	{"spider_eye":1, "spike":1, "apple":1, "egg":1})) # TODO: change
	
	_add_enemy(enemy_abstract.new("water_schnoop",
	"Water Schnoop",
	puzzle_subtraction.new(50),
	30,
	4,
	1,
	{"ghost_hair":2}))
	
	_add_enemy(enemy_abstract.new("clamp", 
	"Clamp", #TODO: change name?
	puzzle_addition_compound.new(10, 50),
	60,
	6,
	1,
	{"spider_eye":1, "spike":1, "apple":1, "egg":1})) # TODO: change
	
	_add_enemy(enemy_abstract.new("water_snail",
	"Water Snail", #TODO: change name!
	puzzle_arithmetic_sequence.new(0, 20, 0, 10, true), 
	40,
	6,
	1,
	{"spider_eye":1, "spike":1, "apple":1, "egg":1})) # TODO: change
	
	_add_enemy(enemy_abstract.new("karen_melon",
	"Karen Melon", 
	puzzle_arithmetic_sequence.new(0, 60, -10, 0, true), 
	60,
	7,
	1,
	{"watermelon":1})) 
	
	_add_enemy(enemy_abstract.new("jungle_schnoop", 
	"Jungle Schnoop", 
	puzzle_subtraction.new(200), 
	20,
	5,
	2,
	{"ghost_hair":2}))
	
	_add_enemy(enemy_abstract.new("hornet", 
	"Hornet", # TODO: change name
	puzzle_addition_compound.new(10, 100),
	40,
	7,
	1,
	{"spike":2, "egg":1})) 
	
	_add_enemy(enemy_abstract.new("cool_banana", 
	"Cool Banana!", # TODO: change name?
	puzzle_subtraction_compound.new(5, 50, true), 
	40,
	7,
	1,
	{"banana":1})) # TODO: change
	
	_add_enemy(enemy_abstract.new("man_go", 
	"Man gO!", # TODO: change name?
	puzzle_subtraction_blank.new(2, 20),
	40,
	7,
	1,
	{"mango":1}))
	
	_add_enemy(enemy_abstract.new("jungle_snail", 
	"Jungle Snail", 
	puzzle_arithmetic_sequence.new(0, 50, 0, 15, true),
	25,
	6,
	2,
	{"mango":1})) # TODO: change
	
	_add_enemy(enemy_abstract.new("jacko",
	"Jacko",
	puzzle_prime_detection.new(100, true),
	10,
	10,
	3,
	{"pumpkin":1, "ghost_hair":1}))
	
	_add_enemy(enemy_abstract.new("delilah",
	"Delilah",
	puzzle_addition_compound.new(),
	10,
	10,
	2,
	{"ghost_hair":2}))
	
	_add_enemy(enemy_abstract.new("plusumad",
	"Plusumad",
	puzzle_addition_negatives.new(100),
	10,
	10,
	2,
	{"math_soul":1}))
	
	_add_enemy(enemy_abstract.new("demultiply",
	"Demultiply",
	puzzle_multi_negatives.new(),
	10,
	10,
	2,
	{"math_soul":2}))
	
	_add_enemy(enemy_abstract.new("diversary",
	"Diversary",
	puzzle_division.new(),
	10,
	10,
	2,
	{"math_soul":2}))
	
	_add_enemy(enemy_abstract.new("disturbing_star",
	"Disturbing Star",
	puzzle_addition_compound.new(10, 150),
	40,
	5,
	1,
	{"star_piece":2}))
	
	_add_enemy(enemy_abstract.new("piece_of_cake", 
	"Piece of Cake",
	puzzle_subtraction_compound.new(5, 100, true),
	40,
	7,
	1,
	{"cake_piece":1}))
	
	_add_enemy(enemy_abstract.new("doom_cupcake",
	"Doom Cupcake",
	puzzle_addition_blank.new(0, 100),
	20,
	5,
	1,
	{"cake_piece":2}))
	
	_add_enemy(enemy_abstract.new("chocolate_meteor",
	"chocolate_meteor",
	puzzle_subtraction_blank.new(0, 100),
	40,
	5,
	1,
	{"cake_piece":2})) # TODO: change?
	
	_add_enemy(enemy_abstract.new("applady",
	"Applady",
	puzzle_even_odd.new(20),
	20,
	1,
	1,
	{"apple":1}))
	
	_add_enemy(enemy_abstract.new("leafonger",
	"Leafonger",
	puzzle_addition_compound.new(5, 20),
	60,
	5,
	1,
	{"leaf":1}))
	
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
	{"snowball":1})) # TODO: change to snowball
	
	_add_enemy(enemy_abstract.new("snowy_cra_babi", 
	"Snowy Cra Babi",
	puzzle_multi_simple.new(5, 15),
	30,
	5,
	1,
	{"ghost_hair":1})) # TODO: change
	
	_add_enemy(enemy_abstract.new("pain_tree", 
	"Pain Tree",
	puzzle_multi_compound.new(2, 10),
	40,
	6,
	1,
	{"leaf":3})) # TODO: change
	
	_add_enemy(enemy_abstract.new("snowy_spider", 
	"Snowy Spider",
	puzzle_addition.new(50, 500),
	15,
	5,
	3,
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
	{"ghost_hair":2, "snowball":1}))
	
	_add_enemy(enemy_abstract.new("snowy_schnoop",
	"Snowy Schnoop",
	puzzle_subtraction_compound.new(15, 150, true),
	40,
	8,
	2,
	{"ghost_hair":3, "snowball":2}))
	
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
	{"ghost_hair":3, "snowball":2})) # TODO: change
	
	_add_enemy(enemy_abstract.new("punguy", 
	"Punguy", 
	puzzle_division_simple.new(10),
	40,
	7,
	1,
	{"ghost_hair":3, "snowball":2})) # TODO: change to mushr0om
	
	_add_enemy(enemy_abstract.new("grandhamster", # TODO: create scene
	"GrandHamster", 
	puzzle_division.new(11, 11),
	45,
	8,
	1,
	{"ghost_hair":3, "snowball":2})) # TODO: change
	
	_add_enemy(enemy_abstract.new("fairy_schnoop", 
	"Fairy Schnoop", 
	puzzle_addition_ultimate_easy.new(3, 95, true),
	50,
	8,
	2,
	{"ghost_hair":3, "snowball":2})) # TODO: change
	
	_add_enemy(enemy_abstract.new("butter_fly", 
	"Butter Fly", 
	puzzle_fractions_simplify.new(10, 10),
	25,
	8,
	2,
	{"ghost_hair":3, "snowball":2})) # TODO: change
	
	_add_enemy(enemy_abstract.new("fairy", 
	"Fairy", 
	puzzle_prime_detection.new(130, false),
	25,
	10,
	2,
	{"ghost_hair":3, "snowball":2})) # TODO: change
	
	_add_enemy(enemy_abstract.new("fairy_owllo", 
	"Fairy Owllo", 
	puzzle_multi_blank.new(3, 20),
	25,
	7,
	2,
	{"ghost_hair":3, "snowball":2}))  # TODO: change
	
	_add_enemy(enemy_abstract.new("dark_owllo", 
	"Dark Owllo", 
	puzzle_division_blank.new(1, 10),
	30,
	8,
	2,
	{"ghost_hair":3, "snowball":2}))  # TODO: change
	
	_add_enemy(enemy_abstract.new("snail_wizard", 
	"Snail Wizard", 
	puzzle_arithmetic_sequence.new(10, 70, -20, 20, true),
	30,
	8,
	3,
	{"ghost_hair":3, "snowball":2})) # TODO: change



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

func get_site_price(zone_id, site_id):
	return zones[zone_id]["sites"][site_id]
	#return sites[site_id]["price"]

func get_boss_star_price(zone_id, boss_id):
	return zones[zone_id]["bosses"][boss_id]

func get_boss_by_id(boss_id):
	return bosses[boss_id]