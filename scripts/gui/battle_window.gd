extends Panel

# turned into battle window in this project (from carfting_window at MathTownResidents)
# the script for the battle window
# 
# The battle only ends when the player pressed the "Accept" button.
# Timeout not ends the battle but reduces the amount of stars and resources
# the enemy drops. And damage HP?
# 
# incorerct answer doesn't grant stars AND lowers the player's HP.
# the enemy stays alive!
# in case of correct answer -> show animation
# in case of incorrect answer -> show another animation.
# Extras:
# * timer ticking and flashing with less than 5 seconds left

var enemy : enemy_abstract

var current_time = 23

# nodes:

onready var timer = $main_container/battle_window/timer
onready var puzzle_displayer = $main_container/battle_window/puzzle_displayer
onready var timer_label = $main_container/battle_window/result_container/time_header_label/time_label
onready var star_label = $main_container/battle_window/result_container/star_container/star_label
onready var dmg_label = $main_container/battle_window/result_container/dmg_container/dmg_label
onready var stars_pop_particle = $main_container/battle_window/result_container/star_container/icon/stars_pop
onready var stars_porminent_particle = $main_container/battle_window/result_container/star_container/icon/stars_porminent

# was the player out of time while crafting this?
var is_timedout = false

# a critical is when the player has only 1 hp, then the star gains are higher
var is_critical = false

signal answer_entered(correct, timout)

# Called when the node enters the scene tree for the first time.
func _ready():
	timer.connect("timeout", self, "update_timer")
	puzzle_displayer.connect("answer_clicked", self, "on_answer_clicked")
	
	set_enemy(enemies_data.get_enemy_by_id("angry_pear"))


func set_enemy(e):
	enemy = e
	setup_enemy()

func get_enemy():
	return enemy

#func set_recipe(r):
#	recipe = r
#	setup_recipe()

func setup_enemy():
	if player_data.get_current_hp() == 1:
		is_critical = true
	else:
		is_critical = false
	
	current_time = enemy.get_time()
	is_timedout = false
	
	# set puzzle
	puzzle_displayer.set_puzzle(enemy.get_puzzle())
	
	# set dmg labels:
	dmg_label.text = str(enemy.get_damage())
	
	# set strars label
	# if critical, stars have higher value and show particles
	if is_critical:
		star_label.text = str(int(enemy.get_stars() * player_data.STARS_CRITICAL_MULTIPLIER))
		stars_pop_particle.emitting = true
		stars_porminent_particle.emitting = true
	else:
		star_label.text = str(enemy.get_stars())
		stars_pop_particle.emitting = false
		stars_porminent_particle.emitting = false
	
	# set time:
	current_time = enemy.get_time() + 1
	update_timer()
	timer.start()

#func setup_recipe():
#	current_time = recipe.get_time()
#	is_timedout = false
#
#	# setup ingredients list:
#	clear_ingredients_list()
#	if recipe.get_ingredients() == {}:
#		var l = Label.new()
#		l.text = "empty"
#		ingredients_list.add_child(l)
#	for id in recipe.get_ingredients().keys():
#		var l = Label.new()
#		l.text = "%s : %d" % [id, recipe.get_ingredients()[id]]
#		ingredients_list.add_child(l)
#
#	# setup the results:
#	clear_results_list()
#	for id in recipe.get_results().keys():
#		var l = Label.new()
#		l.text = "%s : %d" % [id, recipe.get_results()[id]]
#		results_list.add_child(l)
#
#	# set puzzle:
#	puzzle_displayer.set_puzzle(recipe.get_puzzle())
#
#	# set time:
#	current_time = recipe.get_time() + 1
#	update_timer()
#	timer.start()

#func clear_ingredients_list():
#	for c in ingredients_list.get_children():
#		ingredients_list.remove_child(c)
#		c.queue_free()
#
#func clear_results_list():
#	for c in results_list.get_children():
#		results_list.remove_child(c)
#		c.queue_free()

func get_problem():
	return get_enemy().get_puzzle()

func update_timer():
	current_time = current_time - 1
	if current_time <= 0:
		on_timeout()
		timer_label.text = "0"
		timer.stop()
	else:
		timer_label.text = str(current_time)

# called when the time is 0.
func on_timeout():
	is_timedout = true
	star_label.text = str(0)
	stars_pop_particle.emitting = false
	stars_porminent_particle.emitting = false
	#clear_results_list()
#	for id in recipe.get_results().keys():
#		var l = Label.new()
#		l.text = "%s : %d" % [id, 1]
#		results_list.add_child(l)

func on_answer_clicked(correct):
	emit_signal("answer_entered", correct, is_timedout)
