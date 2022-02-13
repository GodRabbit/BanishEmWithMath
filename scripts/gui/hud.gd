extends CanvasLayer

# copyright 2021,2022 Dor "GodRabbit" Shlush
# this file is part of "BanishEmWithMath"

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

# hud script for the overworld scenes.

enum WINDOWS_IDS {NONE, BATTLE_WINDOW, INVENTORY_DISPLAYER, GAME_OVER_WINDOW, TOP_STORIES_WINDOW}
var current_window_id = WINDOWS_IDS.NONE

# a dictionary that hold a boolean value for each window id in the enum
# it holds whether the window pause the player\world.
const IS_WINDOW_PAUSE = {WINDOWS_IDS.NONE:false, 
WINDOWS_IDS.BATTLE_WINDOW:true,
WINDOWS_IDS.INVENTORY_DISPLAYER: false,
WINDOWS_IDS.GAME_OVER_WINDOW: true,
WINDOWS_IDS.TOP_STORIES_WINDOW: false}

# a dictionary that holds whether the window is exclusive
# i.e the window cannot be interrupted by other windows opening
# e.g. carfting window cannot be closed by opening other window.
const IS_WINDOW_EXCLUSIVE = {
WINDOWS_IDS.NONE:false, 
WINDOWS_IDS.BATTLE_WINDOW:true,
WINDOWS_IDS.INVENTORY_DISPLAYER: false,
WINDOWS_IDS.GAME_OVER_WINDOW: true,
WINDOWS_IDS.TOP_STORIES_WINDOW: false
}

# request the main scene to be paused\unpaused
# val is boolean. true = pause
# false = unpause
signal request_pause(val)
signal battle_over(correct, timeout) # battle is done, and the player is alive
signal inventory_opened

# a flag for boss fights; as certain gui elements must consider it.
var is_boss_fight = false

# nodes:
#onready var crafting_manager = $crafting_manager
onready var battle_window = $battle_window
onready var inventory_displayer = $inventory_displayer
onready var inventory_button = $inventory_button
onready var volume_button = $volume_button
onready var game_over_window = $game_over_screen
onready var explosive_dark_heart_particles = $explosive_dark_hearts_particles
onready var settings_window = $settings_window
onready var settings_button = $settings_button
onready var timer_label = $stats_container/HBoxContainer/timer_label
onready var hp_bar = $stats_container/HBoxContainer/hp_bar
onready var top_stories_button = $top_stories_button
onready var top_stories_displayer = $top_stories_displayer

# Called when the node enters the scene tree for the first time.
func _ready():
	battle_window.connect("answer_entered", self, "on_answer_entered")
	
	inventory_button.connect("pressed", self, "on_inventory_button_pressed")
	
	player_data.connect("player_died", self, "on_player_died")
	player_data.connect("won_the_game", self, "on_player_won_the_game")
	player_data.connect("news_notification_changed", self, "on_player_news_notification_changed")
	
	inventory_displayer.connect("request_exit", self, "on_inventory_displayer_request_exit")
	
	settings_window.connect("request_exit", self, "on_settings_window_request_exit")
	settings_button.connect("pressed", self, "on_settings_button_pressed")
	
	volume_button.connect("pressed", self, "on_volume_button_pressed")
	
	top_stories_button.connect("pressed", self, "on_top_stories_button_pressed")
	top_stories_displayer.connect("request_exit", self, "on_top_stories_displayer_request_exit")
	#tile_placing_menu.connect("tile_selected", self, "on_tile_placing_pressed")
	
	update_audio_button()
	update_ui_from_settings()

func _process(delta):
	if game_settings.is_timer_shown():
		var ms = player_data.get_time_elapsed()
		var time_dic = math_util.ms_to_time_dictionary(ms)
		var s = "%02d:%02d:%02d.%d" % [time_dic["hrs"], time_dic["mnts"], time_dic["secs"], time_dic["ms"]]
		timer_label.text = s

# is this hud on a boss fight?
func set_is_boss_fight(value : bool):
	is_boss_fight = value
	if value:
		inventory_button.disabled = true
		inventory_button.hide()
	else:
		inventory_button.disabled = false
		inventory_button.show()

# gets the window node based on the window_id enum
# settings window is not here on purpose. it can actually be open while other windows are open
func get_window_node(window_id):
	match window_id:
		WINDOWS_IDS.NONE:
			return null
		WINDOWS_IDS.BATTLE_WINDOW:
			return battle_window
		WINDOWS_IDS.INVENTORY_DISPLAYER:
			return inventory_displayer
		WINDOWS_IDS.GAME_OVER_WINDOW:
			return game_over_window
		WINDOWS_IDS.TOP_STORIES_WINDOW:
			return top_stories_displayer

# closes all the windows opened.
func close_all_windows():
	# why not just use <current_window>?
	# loops through the windows ids to check which one is open
	for e in WINDOWS_IDS: # this is like looping over keys of dictionary
		var val = WINDOWS_IDS[e] # the actual value
		if val != WINDOWS_IDS.NONE:
			var w = get_window_node(val)
			if w != null:
				w.hide()
	
	# extra details:
	top_stories_button.pressed = false

# the only way to close an exclusive window.
# exclusive window is a window that cannot be closed by opening other windows and
# it ignores cancelling operation by the player.
func close_exclusive_window():
	close_all_windows()
	current_window_id = WINDOWS_IDS.NONE
	emit_signal("request_pause", false)

# shows a window depending on the window id
func show_window(window_id):
	# if the current window opened is exclusive, dont allow new open orders
	# the only way to close exclusive windows is with the function <close_exclusive_window>
	if IS_WINDOW_EXCLUSIVE[current_window_id]:
		return
	
	# close other windows
	close_all_windows()
	
	# sets the id for the new window:
	current_window_id = window_id
	
	# special cases:
	match window_id:
		WINDOWS_IDS.INVENTORY_DISPLAYER:
			# before inventory displayer is shown, you need to update the gui
			# from the global player.
			inventory_displayer.update_gui()
			emit_signal("inventory_opened")
#		WINDOWS_IDS.CRAFTING_MANAGER:
#			pass
#			# before the crafting manager is shown, you need to update which 
#			# recipes are shown.
##			var arr_ids = player_data.get_crafting_recipes_ids()
##			crafting_manager.set_ids(arr_ids)
	
	# gets the node to show:
	var w = get_window_node(window_id)
	if w != null:
		w.show()
	
	# send a un\pause request:
	emit_signal("request_pause", IS_WINDOW_PAUSE[window_id])

# sets the correct puzzle\recipe in the crafting window
# get from crafting manager.
func set_enemy(e : enemy_abstract):
	battle_window.set_enemy(e)

# deprecated
# signal from crafting manager
#func on_crafting_pressed(r):
#	set_crafting_recipe(r)
#	show_window(WINDOWS_IDS.CRAFTING_WINDOW)

# signal from battle_window
# <c> is whether the answer is correct or not
# <t> is whether there was a timeout
func on_answer_entered(c, t):
	# close the crafting window:
	close_exclusive_window()
	
	if !c:
		battle_window.get_problem()._print_puzzle()
	
	# process battle result:
	if c: # the player won:
		player_data.absorb_enemy(battle_window.get_enemy(), t)
		emit_signal("battle_over", c, t)
		
		# TODO: change to a better sound? Its really hard to find something good
		sound_manager.play_ui_sound("ui_success")
	else:
		explosive_dark_heart_particles.restart()
		# sound effect:
		sound_manager.play_ui_sound("sfx_negative")
		
		# the player lost
		var dmg  = battle_window.get_enemy().get_damage()
		player_data.add_hp(-dmg)
		
		if !player_data.is_dead():
			emit_signal("battle_over", c, t)
	

# toggle inventory:
func on_inventory_button_pressed():
	if inventory_displayer.is_visible_in_tree():
		# all hiding and showing must go through these functions
		# even if its a little ineffecient
		show_window(WINDOWS_IDS.NONE)
	else:
		show_window(WINDOWS_IDS.INVENTORY_DISPLAYER)

## signal from crafting_button
## toggle crafting_manager:
#func on_crafting_button_pressed():
#	if crafting_manager.is_visible_in_tree():
#		show_window(WINDOWS_IDS.NONE)
#	else:
#		show_window(WINDOWS_IDS.CRAFTING_MANAGER)

# start a battle with enemy e
func call_battle(e : enemy_abstract):
	set_enemy(e)
	show_window(WINDOWS_IDS.BATTLE_WINDOW)

# signal from player
# show game over screen
func on_player_died():
	hp_bar.set_alternate(true)
	game_over_window.set_won(false)
	show_window(WINDOWS_IDS.GAME_OVER_WINDOW)

# signal from player
# show game over screen
func on_player_won_the_game():
	hp_bar.set_alternate(true)
	game_over_window.set_won(true)
	show_window(WINDOWS_IDS.GAME_OVER_WINDOW)

# signal from inventory displayer
# the exit button on inventory_displayer was pressed
func on_inventory_displayer_request_exit():
	show_window(WINDOWS_IDS.NONE)

# DEPRECATED
# updates the graphic for the audio button
func update_audio_button():
	var audio_lvl = game_settings.get_audio_level("master")
	var path = "res://images/gui/volume_%d.png" % audio_lvl
	volume_button.texture_normal = load(path)

func on_volume_button_pressed():
	game_settings.set_audio_level("master", game_settings.get_audio_level("master") + 1)
	
	# update image:
	update_audio_button()

func on_settings_button_pressed():
	if settings_window.is_visible_in_tree():
		settings_window.hide()
	else:
		settings_window.show()

func on_settings_window_request_exit():
	if settings_window.is_visible_in_tree():
		update_ui_from_settings()
		settings_window.hide()

# a function to update set to update the ui of the HUD from the game_settings
func update_ui_from_settings():
	# timer ui:
	if game_settings.is_timer_shown():
		timer_label.show()
	else:
		timer_label.hide()
	
	# should the news button be hidden?
	if game_settings.get_show_news():
		top_stories_button.show()
	else:
		top_stories_button.hide()
	
	if !game_settings.get_enable_news_notifications():
		top_stories_button.remove_particles()

# toggle visibility of the story_displayer
func _toggle_top_stories_displayer():
	if top_stories_displayer.is_visible_in_tree():
		top_stories_displayer.hide()
		top_stories_button.pressed = false
	else:
		top_stories_displayer.setup_stories()
		top_stories_displayer.show()
		top_stories_button.pressed = true

# signal from top_stories_button
# close or open the top_stories_displayer
func on_top_stories_button_pressed():
	_toggle_top_stories_displayer()

# signal from top_stories_displayer
# close the top_stories_displayer
func on_top_stories_displayer_request_exit():
	_toggle_top_stories_displayer()

# signal from player
# show notification on the 'phone' (top_stories_button)
# val unnecessery?
func on_player_news_notification_changed(val : bool):
	top_stories_button.update_gui()
