extends Node2D

# copyright 2021,2022 Dor "GodRabbit" Shlush
# this file is part of "BanishEmWithMath"

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

# An overworld scene that connects to combat, market and more.

const SITES_LOCATIONS = [Vector2(128, 136), Vector2(176, 288), Vector2(427, 294),
Vector2(446, 160), Vector2(792, 208), Vector2(888, 360), Vector2(591, 450),
Vector2(243, 454)]

var current_zone = "zone1"

# nodes:
onready var give_up_button = $give_up_button
onready var site_container = $site_container
onready var hud = $hud

const BACKGROUND_MUSIC_ID = "background-loop-melodic-techno-03-2691"

# Called when the node enters the scene tree for the first time.
func _ready():
	give_up_button.connect("pressed", self, "on_give_up_button_pressed")
	
	if sound_manager.current_music_id != BACKGROUND_MUSIC_ID:
		sound_manager.play_music(BACKGROUND_MUSIC_ID)
	
	hud.set_is_boss_fight(false)
	update_gui()
	
	# add random news stories every now and then (but not when first entering)
	if player_data._get_visited_to_story_ratio() >= 3.0:
		# if the player was barely getting news stories -> make sure to add another
		# (unlucky prevention)
		player_data.add_random_top_story()
	elif player_data._get_visited_to_story_ratio() > 0.0:
		randomize()
		var num = randi() % 10
		if num <= 5:
			player_data.add_random_top_story()

func on_give_up_button_pressed():
	transition.fade_to_main_menu()

func _input(event):
	var allow_cheating = game_settings.settings["game_data"]["allow_cheating"]
	if event.is_action_released("ui_give_money") && allow_cheating:
		player_data.add_money(1300)
		player_data.add_stars(1000)
	
	if event.is_action_pressed("ui_add_story") && allow_cheating:
		player_data.add_random_top_story()

func _empty_site_container():
	# p are points to place the sites buttons
	for p in site_container.get_children():
		if p.get_children().size() > 0:
			for c in p.get_children():
				p.remove_child(c)
				c.queue_free()

func insert_to_site_container(n):
	for p in site_container.get_children():
		if p.get_children().size() == 0:
			p.add_child(n)

func update_gui():
	 # update site container:
	_empty_site_container()
	var sites = enemies_data.zones[current_zone]["sites"].keys()
	
	for s in sites:
		var b = load("res://scenes/gui/site_button.tscn").instance()
		insert_to_site_container(b)
		b.set_site_id(s)
		#b.position = pos
		b.update_gui()
		
	# TODO: add the same for boss fights
	
