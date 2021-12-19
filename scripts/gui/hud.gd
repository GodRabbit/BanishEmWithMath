extends CanvasLayer

# copyright 2021 Dor "GodRabbit" Shlush
# this file is part of "BanishEmWithMath"

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

# hud script for the overworld scenes.

enum WINDOWS_IDS {NONE, BATTLE_WINDOW, INVENTORY_DISPLAYER, GAME_OVER_WINDOW}
var current_window_id = WINDOWS_IDS.NONE

# a dictionary that hold a boolean value for each window id in the enum
# it holds whether the window pause the player\world.
const IS_WINDOW_PAUSE = {WINDOWS_IDS.NONE:false, 
WINDOWS_IDS.BATTLE_WINDOW:true,
WINDOWS_IDS.INVENTORY_DISPLAYER: false,
WINDOWS_IDS.GAME_OVER_WINDOW: true}

# a dictionary that holds whether the window is exclusive
# i.e the window cannot be interrupted by other windows opening
# e.g. carfting window cannot be closed by opening other window.
const IS_WINDOW_EXCLUSIVE = {
WINDOWS_IDS.NONE:false, 
WINDOWS_IDS.BATTLE_WINDOW:true,
WINDOWS_IDS.INVENTORY_DISPLAYER: false,
WINDOWS_IDS.GAME_OVER_WINDOW: true
}

# request the main scene to be paused\unpaused
# val is boolean. true = pause
# false = unpause
signal request_pause(val)
signal battle_over(correct, timeout) # battle is done, and the player is alive
signal inventory_opened

# nodes:
#onready var crafting_manager = $crafting_manager
onready var battle_window = $battle_window
onready var inventory_displayer = $inventory_displayer
onready var inventory_button = $inventory_button
onready var volume_button = $volume_button
onready var game_over_window = $game_over_screen
onready var explosive_dark_heart_particles = $explosive_dark_hearts_particles

# Called when the node enters the scene tree for the first time.
func _ready():
	battle_window.connect("answer_entered", self, "on_answer_entered")
	
	inventory_button.connect("pressed", self, "on_inventory_button_pressed")
	
	player_data.connect("player_died", self, "on_player_died")
	
	inventory_displayer.connect("request_exit", self, "on_inventory_displayer_request_exit")
	
	volume_button.connect("pressed", self, "on_volume_button_pressed")
	
	#tile_placing_menu.connect("tile_selected", self, "on_tile_placing_pressed")
	
	update_audio_button()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

# gets the window node based on the window_id enum
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
	
	print("Answer is " + str(c))
	if !c:
		battle_window.get_problem()._print_puzzle()
	
	# process battle result:
	if c: # the player won:
		player_data.absorb_enemy(battle_window.get_enemy(), t)
		emit_signal("battle_over", c, t)
	else:
		explosive_dark_heart_particles.restart()
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
	show_window(WINDOWS_IDS.GAME_OVER_WINDOW)

# signal from inventory displayer
# the exit button on inventory_displayer was pressed
func on_inventory_displayer_request_exit():
	show_window(WINDOWS_IDS.NONE)

# updates the graphic for the audio button
func update_audio_button():
	var audio_lvl = game_settings.get_audio_level("master")
	var path = "res://images/gui/volume_%d.png" % audio_lvl
	volume_button.texture_normal = load(path)

func on_volume_button_pressed():
	game_settings.set_audio_level("master", game_settings.get_audio_level("master") + 1)
	
	# update image:
	update_audio_button()
	
	# debug:
	print("music db is %f" % game_settings.get_audio_db("music"))
	
