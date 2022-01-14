extends Node

# copyright 2021,2022 Dor "GodRabbit" Shlush
# this file is part of "BanishEmWithMath"

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

# global player data

# nodes:
onready var cooldown_timer = $cooldown_timer

const DIFFICULTIES = {
	"SUPER_EASY":{"max_hp":10, "exit_penalty":0},
	"EASY":{"max_hp":7, "exit_penalty":5},
	"NORMAL":{"max_hp":5, "exit_penalty":10},
	"HARD":{"max_hp":3, "exit_penalty":15},
	"HARDCORE":{"max_hp":1, "exit_penalty":20}
}

var unlocked_sites = ["farm"]

# stats:
# energy deprecated
var max_energy = 50
var current_energy = max_energy

const MAX_MONEY = 999999999
var money = 0


# TODO: add a way to add hp upgrades and defenses to protect hp.
var max_hp = 5
var current_hp = max_hp

var exit_penalty = 10 # how many stars you lose on site exit
const MAX_STARS = 999999999
var current_stars = 0
const STARS_CRITICAL_MULTIPLIER = 1.5 # by how much stars are added on critical (player has 1 hp)

var difficulty = "NORMAL"

# the last difficulty the player chose, and is now defaulted everytime he enters main menu
var prefferd_difficulty = "normal"

var player_inventory = inventory.new(25)

# technicalities:
# cooldown for pressing on enemies
const PRESSING_COOLDOWN_TIME = 2 # seconds
var pressing_cooldown = false

var current_zone = "zone1" # the curretn zone. The age group thhat governs the sites
var current_site = "farm" # site id for the next combat
var current_boss = "galactic_cake" # boss id for the next boss combat

# timer data:
var timer_activated = false
var player_start_time = 0

# DEPRECATED IN THIS GAME
# every time the overworld player intersect with a crafting tile, the crafting tile
# inserts its id into this dictionary as a key, and removes
# itself  when overworld player exits. the value is the number of intersecting areas.
# NOTE: for inserting and removing of the tiles look at the overworld player script
var overlapping_crafting_tiles = {}

signal energy_depleted
signal player_died
signal hp_changed
signal stars_changed(val) # val is the value by which the stars changed
signal money_changed

# Called when the node enters the scene tree for the first time.
func _ready():
	setup_player()
	cooldown_timer.connect("timeout", self, "on_cooldown_timer_tmeout")

# called when starting new game. restart all the values to starting values
func setup_player(_difficulty = "normal"):
	difficulty = _difficulty.to_upper()
	max_hp = DIFFICULTIES[difficulty]["max_hp"]
	exit_penalty = DIFFICULTIES[difficulty]["exit_penalty"]
	
	set_hp(max_hp)
	set_stars(0)
	current_site = "farm"
	player_inventory.empty_inventory()
	money = 0
	unlocked_sites = ["farm"]
	
	reset_timer_data()

func get_inventory():
	return player_inventory

func get_max_energy():
	return max_energy

func get_energy():
	return current_energy

func set_energy(e):
	if e >= max_energy:
		current_energy = max_energy
	elif e <= 0:
		current_energy = 0
		emit_signal("energy_depleted")
	else:
		current_energy = e

func add_energy(e):
	set_energy(get_energy() + e)

func get_max_hp():
	return max_hp

func get_current_hp():
	return current_hp

func set_hp(v):
	if v >= get_max_hp():
		current_hp = get_max_hp()
	elif v <= 0:
		current_hp = 0
		emit_signal("player_died")
	else:
		current_hp = v
	emit_signal("hp_changed")

func add_hp(v):
	set_hp(get_current_hp() + v)

# try to eat 1 unit of the item at index
# if the inventory is empty at this slot
# do nothing
func eat_item_at(index):
	var s = player_inventory.get_stack_at(index)
	if !s.is_empty(): # the stack is not empty?
		# get data about the item
		var item_id = s.get_item_id()
		var item = items_data.get_item_by_id(item_id)
		var hp = item["hp"]
		
		# remove 1 of the items at the stack:
		player_inventory.remove_item_at(index, 1)
		
		# add the hp to the player:
		add_hp(hp)
	else:
		return

func sell_item_at(index):
	var s = player_inventory.get_stack_at(index)
	if !s.is_empty():
		# get item's data:
		var item_id = s.get_item_id()
		var item = items_data.get_item_by_id(item_id)
		var sell_price = item["price"]
		
		# remove 1 of items at the stack
		player_inventory.remove_item_at(index, 1)
		
		# add the money:
		add_money(sell_price)
	else:
		return

func is_dead():
	return get_current_hp() <= 0

func get_current_stars():
	return current_stars

func set_stars(v):
	var tmp = current_stars
	if v >= MAX_STARS:
		current_stars = MAX_STARS
	elif v <= 0:
		current_stars = 0
	else:
		current_stars = v
	emit_signal("stars_changed", current_stars - tmp) # the signal is for the change in stars

func add_stars(v):
	set_stars(get_current_stars() + v)

func apply_exit_penalty():
	add_stars(-exit_penalty)

func get_money():
	return money

func set_money(v):
	if v >= MAX_MONEY:
		money = MAX_MONEY
	elif v <= 0:
		money = 0
	else:
		money = v
	emit_signal("money_changed")

func add_money(v):
	set_money(get_money() + v)

# checks if the recipe can crafted by the player
# i.e if the player has the ingrediendts
# doesn't check if there's place in the inventory for the result, the residue will
# be inserted into a special chest later
func check_recipe(r : crafting_recipe):
	# checks if the inventory has all the ingredients:
	for k in r.get_ingredients().keys():
		# how much you need for the recipe:
		var a = r.get_ingredients()[k]
		
		# the amount in the inventory
		var t = player_inventory.get_total_amount(k)
		
		if a > t:
			return false
	return true

# automatically adds the result from the recipe <r>, into the inventory
# with auto-sort
func add_result_from_recipe(r : crafting_recipe):
	var results = r.get_results()
	player_inventory.add_dictionary(results)

# remove the ingredients and adds the results of a recipe.
# attempting this function when you don't have all the ingredients
# will have bizzare beahviour, so check first.
# right now, if the player's inventory is full the residue is deleted!
func process_recipe(r : crafting_recipe, timeout = false):
	var ingredients = r.get_ingredients()
	var results = r.get_results().duplicate()
	
	# in case the player timedout, the results all get reduced:
	# if the results were higher than 1, get them to 1. if they were
	# already 1, turn them into 0.
	if timeout:
		for k in results.keys():
			if results[k] > 1:
				results[k] = 1
			else:
				results.erase(k)
	
	player_inventory.remove_dictionary(ingredients)
	player_inventory.add_dictionary(results)

# called when an enemy has died, and the player is still alive
# takes the stars from the enemy and adds it's items to the inventory
# if there was a timeout, there's a chance the player will only take
# a few of the items and no stars
func absorb_enemy(e : enemy_abstract, timeout = false):
	if !timeout:
		if get_current_hp() == 1: # if the player's hp is 1, you get 50% more stars!
			add_stars(int(e.get_stars()*STARS_CRITICAL_MULTIPLIER))
		else:
			add_stars(e.get_stars())
		player_inventory.add_dictionary(e.get_items())
	else:
		# no stars!!
		# each item has 50% chance of being added when a timeout happens
		for k in e.get_items().keys():
			var amount = 0
			for i in range(0, e.get_items()[k]):
				randomize()
				var b = randi() % 2
				if b == 0:
					amount += 1
			player_inventory.add_item(k, amount)

# gets all the crafting tiles the player collides with currently
# and return the crafting recipes ids of all those tiles
#func get_crafting_recipes_ids():
#	var result = []
#
#	# loop through the crafting tiles the player intersected with:
#	for tile_id in overlapping_crafting_tiles.keys():
#		# get how many the player intersect ith RIGHT NOW
#		var v = overlapping_crafting_tiles[tile_id]
#
#		# is it more than 0?
#		if v > 0:
#			# gets all the recipes of this tile:
#			var recipes = crafting_tiles_data.get_crafting_recipes_by_id(tile_id)
#
#			# loop through them and add them to <result>:
#			for r in recipes:
#				if !(r in result):
#					result.append(r)
#
#	return result

func start_pressing_cooldown():
	cooldown_timer.start(PRESSING_COOLDOWN_TIME)
	pressing_cooldown = true

func can_interact_with_enemies():
	return !pressing_cooldown

# signal from cooldown_timer
# on timeout the player can press enemies again
func on_cooldown_timer_tmeout():
	pressing_cooldown = false
	cooldown_timer.stop()

# sets the current site to side id <s>
func set_current_site(s):
	current_site = s

func get_current_site():
	return current_site

func get_current_zone():
	return current_zone

func set_current_zone(z_id):
	current_zone = z_id

func set_current_boss(boss_id):
	current_boss = boss_id

func get_current_boss():
	return current_boss

# unlocks the site. doesn't include the price and reduction of money
# check "purchase_site"
func unlock_site(site_id):
	unlocked_sites.append(site_id)

# attempt to purchase a site as long as the player has enough money
# otherwise do noting!
func purchase_site(site_id):
	# TODO: Add item prices for purchase
	var price_dic = enemies_data.get_site_price(get_current_zone(), site_id)
	var price = price_dic["money"]
	if price <= money:
		# loop through the items in price_dic and check you have enough:
		var found = false # found an item you dont have enough of?
		for k in price_dic.keys():
			if k != "money":
				# how much of item <k> the player has?
				var amount = player_inventory.get_total_amount(k)
				
				# enough to pay for this site? no -> return and do nothing.
				if amount < price_dic[k]:
					found = true
					return
		
		if !found: # the site can be purchased!
			# purchase:
			for k in price_dic.keys():
				if k != "money":
					player_inventory.remove_item(k, price_dic[k])
			add_money(-price)
			unlock_site(site_id)


func check_site(site_id):
	if unlocked_sites.has(site_id):
		return true
	else:
		return false

func reset_timer_data():
	timer_activated = false
	player_start_time = 0

func start_timer():
	timer_activated = true
	player_start_time = OS.get_ticks_msec()

func is_timer_activated():
	return timer_activated

func get_player_start_time():
	return player_start_time

# gets the time elapsed in miliseconds
func get_time_elapsed():
	if is_timer_activated():
		var current = OS.get_ticks_msec()
		return current - get_player_start_time()
	else:
		return -1 # for debug purposes
