extends Node


# a global class the holds all the enemies data.
# each enemy must be registered and added to this class.

var enemies_collection = []

var sites = {
"farm":
	{"enemies":["angry_pear", "angry_apple", "wheaty", "sad_eggy"],
	"backgrounds":["farm1"],
	"price":0,
	"name":"Farm"},
"jungle":
	{"enemies":["spikey_boi", "boo_da_rang", "grape_moment", "spider"],
	"backgrounds":["jungle1"],
	"price":30,
	"name":"Jungle"},
"ocean":
	{"enemies":["cra_babi", "grape_moment", "boo_da_rang"],
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
	"name":"The White Board"}}


# Called when the node enters the scene tree for the first time.
func _ready():
	# can this be jsoned??
	_add_enemy(enemy_abstract.new("spider", # id
	"Spider", # name
	puzzle_addition.new(), # puzzle
	30, # time
	2, # stars
	1, # damage
	{"spider_leg":1, "spider_eye":1})) 
	
	_add_enemy(enemy_abstract.new("angry_pear",
	"Angry Pear",
	puzzle_multi_simple.new(),
	30,
	3,
	1,
	{"pear":2}))
	
	_add_enemy(enemy_abstract.new("angry_apple",
	"Angry Apple",
	puzzle_subtraction_simple.new(),
	30,
	3,
	1,
	{"apple":2}))
	
	_add_enemy(enemy_abstract.new("wheaty",
	"Wheaty",
	puzzle_addition_compound.new(),
	30,
	5,
	1,
	{"wheat":4}))
	
	_add_enemy(enemy_abstract.new("sad_eggy",
	"Sad Eggy",
	puzzle_division_simple.new(),
	30,
	5,
	1,
	{"egg":1}))
	
	_add_enemy(enemy_abstract.new("spikey_boi",
	"Spikey Boi",
	puzzle_addition_hard.new(),
	10,
	5,
	2,
	{"spike":1}))
	
	_add_enemy(enemy_abstract.new("grape_moment",
	"Grape Moment",
	puzzle_subtraction_simple.new(),
	10,
	5,
	1,
	{"grape":1}))
	
	_add_enemy(enemy_abstract.new("cra_babi",
	"Cra Babi",
	puzzle_division.new(),
	15,
	5,
	1,
	{"spider_eye":1, "spike":1}))
	
	_add_enemy(enemy_abstract.new("boo_da_rang",
	"Boo Da Rang",
	puzzle_multi_compound.new(),
	30,
	7,
	1,
	{"spider_eye":1, "spike":1, "apple":1, "egg":1})) # whats going on..?
	
	_add_enemy(enemy_abstract.new("jacko",
	"Jacko",
	puzzle_prime_detection_easy.new(),
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

func get_site_price(site_id):
	return sites[site_id]["price"]
