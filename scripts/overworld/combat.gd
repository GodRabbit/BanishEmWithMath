extends Node2D

# copyright 2021,2022 Dor "GodRabbit" Shlush
# this file is part of "BanishEmWithMath"

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

# a master scene for the combat

var ENEMY_POSITIONS = [Vector2(600, 88), Vector2(216, 224), Vector2(760, 400), Vector2(456, 448),
Vector2(432, 168), Vector2(840, 168), Vector2(952, 432), Vector2(608, 440), Vector2(328, 472),
Vector2(80, 104), Vector2(96, 360), Vector2(550, 264), Vector2(712, 240),
Vector2(328, 304)]

# how many enemies can appear
const MAX_ENEMIES = 6
const MIN_ENEMIES = 4

const ENEMY_PATH = "res://scenes/overworld/enemies/%s.tscn"
const BACKGROUND_PATH = "res://images/backgrounds/%s.png"

# the site where the combat occur
var site = "none"

# nodes:
onready var hud = $hud
onready var objects_node = $objects
onready var exit_button = $exit_container/exit_button
onready var exit_penalty_label = $exit_container/number_label
onready var background_sprite = $background
onready var explosive_star_particles = $particles/explosive_star_particles
onready var area_cleared_screen = $hud/area_cleared_screen

# Called when the node enters the scene tree for the first time.
func _ready():
	hud.connect("battle_over", self, "on_battle_over")
	hud.connect("request_pause", self, "on_pause_requested")
	hud.show_window(hud.WINDOWS_IDS.NONE)
	
	exit_button.connect("pressed", self, "on_exit_button_pressed")
	
	area_cleared_screen.connect("exit_request", self, "on_area_cleared_screen_exit_request")
	
	setup_combat()
#	# connect objects to signal for crafting:
#	for o in objects_node.get_children():
#		if o.is_in_group("object_areas"):
#			o.connect("object_pressed", self, "on_object_area_pressed")
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

# create <N> vector2 for possible positions of enemies
func _create_enemy_positions(N, start_pos, end_pos):
	ENEMY_POSITIONS = []
	var x_range = end_pos.x - start_pos.x
	var y_range = end_pos.y - start_pos.y
	for i in range(0, N):
		var x = rand_range(0, x_range)
		var y = rand_range(0, y_range)
		
		var pos = start_pos + Vector2(x, y)
		ENEMY_POSITIONS.append(pos)
		


# setup the enemies and scene for the combat to start
# <is_first> is true when this is the first setup, like when the combat is called from the overworld
# it will be false in case the player wants to stay here after the battle is over for more enemies to come
func setup_combat(is_first = true):
	hud.set_is_boss_fight(false)
	_create_enemy_positions(10, Vector2(216, 208), Vector2(1728, 888))
	
	# remove objects from previous session:
	for o in objects_node.get_children():
		objects_node.remove_child(o)
		o.queue_free()
	
	exit_penalty_label.text = "-"+str(player_data.exit_penalty)
	
	# get the site from the player data
	site = player_data.get_current_site()
	
	# pick a background:
	if is_first:
		var b_id = enemies_data.get_background_id_by_site(site)
		background_sprite.texture = load(BACKGROUND_PATH % b_id)
	
	# randomly pick the amount of enemies on the screen
	randomize()
	var e_amount = MIN_ENEMIES + randi() % (MAX_ENEMIES - MIN_ENEMIES + 1)
	
	# get the array of enemies ids:
	var e_arr = enemies_data.get_enemies_by_site(site)
	
	# in case of error, just load the farm instead
	if e_arr == []:
		e_arr = enemies_data.get_enemies_by_site("farm")
	
	# a duplicate of enemy positions so you wouldn't be able to choose the same
	#  spot twice
	var e_poses = ENEMY_POSITIONS.duplicate(true)
	
	# load enemies and put them under objects_node
	for i in range(0, e_amount):
		# choose random enemy id from enemies in this site
		var index = randi() % e_arr.size()
		var e_id = e_arr[index]
		
		# choose position (re-use the index var)
		index = randi() % e_poses.size()
		var pos = e_poses[index]
		e_poses.remove(index) # so you won't get the same pos twice
		
		# load & instance the enemy:
		var enemy_scene = load(ENEMY_PATH % e_id).instance()
		objects_node.add_child(enemy_scene)
		enemy_scene.global_position = pos
		enemy_scene.connect("object_pressed", self, "on_object_area_pressed")
	
	# play music:
	if is_first:
		var music_arr = enemies_data.get_site_music(site)
		var music_id = music_arr[1]
		var folder_name = music_arr[0]
		if music_id != "":
			sound_manager.play_music(folder_name, music_id)

# go through every object that should pause while a window is open
# and (un)pause
func pause_world(val : bool):
	# pause all the enemies so they won't be able to be clicked
	for o in objects_node.get_children():
		if o.is_in_group("object_areas"):
			o.set_pause(val)


# destroy an object from node_objects
func _destroy_object(o):
	o.on_death()
	yield(o, "death_animation_over")
	deploy_stars_particles(o.global_position)
	objects_node.remove_child(o)
	o.queue_free()
	
	# check if there are no more enemies, to return to the overworld:
	# if the player is dead you cant move to the next scene
	if objects_node.get_children().size() == 0 && !player_data.is_dead():
		on_area_cleared()

# destroy objects that are object_areas, that are listed for destruction
func _remove_fired_objects():
	for o in objects_node.get_children():
		if o.is_in_group("object_areas"):
			if o.is_fired():
				_destroy_object(o)


# signal from hud
func on_battle_over(c, t):
	if c:
		# remove dead enemies:
		_remove_fired_objects()
	if !c:
		# if the question is incorrect set all the objects as unfired
		for o in objects_node.get_children():
			if o.is_in_group("object_areas"):
				o.fired = false

# signal from hud
# v is boolean. true = pause; false = unpause
func on_pause_requested(v):
	pause_world(v)

# signal from object areas
# e_id is enemy id
func on_object_area_pressed(e_id):
	# show crafting window
	var e = enemies_data.get_enemy_by_id(e_id)
	hud.call_battle(e)

# signal from exit button
func on_exit_button_pressed():
	if !player_data.is_dead():
		player_data.apply_exit_penalty()
		transition.fade_to_overworld()

# called when all the enemies are dead
func on_area_cleared():
	pause_world(true)
	area_cleared_screen.show()

func deploy_stars_particles(pos):
	explosive_star_particles.global_position = pos
	explosive_star_particles.restart()

# basically, its called when one of the buttons on "area_cleared_screen" was pressed
func on_area_cleared_screen_exit_request(val):
	if val: # the player wants to leave (pressed continue)
		player_data.add_visited_site(site)
		transition.fade_to_overworld()
	else: # the player want to stay (pressed 'wait_here')
		pause_world(false)
		setup_combat(false)
		area_cleared_screen.hide()
