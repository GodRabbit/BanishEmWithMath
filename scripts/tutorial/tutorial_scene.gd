extends Node2D

# copyright 2021,2022 Dor "GodRabbit" Shlush
# this file is part of "BanishEmWithMath"

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

var current_phase = "prologue"
var current_dialogue = []
var current_dialogue_index = 0

# if the player sell an item while the tutorial is working mark that as true, 
# so the tutorial can continue!
var item_sold = false

var input_cooldown = false

# nodes:
onready var dialogue_label = $hud/dialogue_panel/dialogue_container/hbox/dialogue_label
onready var dialogue_button = $hud/dialogue_panel/dialogue_container/hbox/dialogue_button
onready var explosive_star_particles = $explosive_star_particles
onready var input_timer = $input_timer # DEPRECATED
onready var combat_anim = $combat_anim
onready var tutorial_schnoop = $mini_combat/tutorial_schnoop
onready var hud = $hud
onready var exit_button = $hud/exit_button

# Called when the node enters the scene tree for the first time.
func _ready():
	exit_button.connect("pressed", self, "on_exit_button_pressed")
	input_timer.connect("timeout", self, "on_input_timer_cooldown") # DEPRECATED
	dialogue_button.connect("pressed", self, "on_dialogue_button_pressed")
	hud.connect("inventory_opened", self, "on_inventory_opened")
	hud.inventory_displayer.connect("item_sold", self, "on_sell")
	# combat signals
	tutorial_schnoop.connect("object_pressed", self, "on_tutorial_schnoop_pressed")
	hud.connect("battle_over", self, "on_battle_over")
	set_phase("prologue")
	combat_anim.play("close_simulation")



# each phase has dialogue, and at the end of the dialogue the event function
# will be called.
var phases = {"prologue":{
	"dialogue":["Welcome to the catastrophe headquarters!",
	"Sorry I can't be here on your first day of training, but this little screen will do",
	"As you obviously know, the earth has been invaded by alien creatures",
	"they already infected most of our world, and even parts of the universe",
	"You are here because you have a personal duty to help quarantine this menace",
	"Using our newest technology, The Banishing Machine.. hrm.. trademark... ",
	"We can banish those pesky creatures to another dimension! (hrm..so it would be someone else's problem)",
	"You use it by aiming at an enemy, and solving a calculation. Pretty simple most of the times...hrm..",
	"Successful calculation will banish the enemy to oblivion, and even give you some of its parts as loot!",
	"hrm... but... a failed calculation will enrage it and give it an opportunity to hurt you",
	"hrmm...so that will be an ill advised life choice",
	"I think it's time for a practice run. I captured one of those abominations, it's a baby Schnoop",
	"hrm...I probably should activate the simulation chamber..."],
	"event":"on_prologue"
}, 
			  "hit_enemy":{
				"dialogue":["Lets go.. hrm...",
				"Click on it for an attempt to banish it"],
				"event":"on_hit_enemy"
			},
			"enemy_missed":{
				"dialogue":["Oh ... hrm... it's still here! try to banish it again!"],
				"event":"on_enemy_missed"
			},
			"prologue2":{
				"dialogue":["Well, you're clearly a natural",
				"Just remember... hrm...  stronger aliens can hurt a lot and are harder to banish",
				"Before the training is done, you need to know how to get around. Those creatures infected many remote places",
				"We have the technology to teleport you to key sites of infection, but those teleporters aren't free",
				"they need gems for an initial recharge. Luckily, those aliens drops items that you can sell for gems, try it out "],
				"event":"on_prologue2"
			},
			  "solve_puzzle":{
				"dialogue":["Now you should finish the banishing process with a calculation"],
				"event":"on_solve_puzzle"
			}, 
			  "transition_overworld":{ # Deprecated? probably yes.
				"dialogue":["Now that all the enemies are gone we can return to our base"],
				"event":"on_transition_overworld"
			},
			"open_inventory":{
				"dialogue":["Open the bag on the right to see your inventory"],
				"event":"on_open_inventory"
			},
			  "sell":{
				"dialogue":["Now you can sell or eat the items you got",
				"Look to the right to see how much each item is worth and how much health you're going to replanish if you eat it",
				"While some items may look mighty delicious, some can hurt you if you eat them",
				"Well.. hrm... We need gems to recharge those teleporters, so try and sell something from your inventory"],
				"event":"on_sell"
			}, 
			  "purchase_site":{ # DEPRECATED
				"dialogue":["Good job!"],
				"event":"on_purchase_site"
			},
			  "fight_second_enemy":{ # DEPRECATED
				"dialogue":["Good job!"],
				"event":""
			}, 
			  "end":{ 
				"dialogue":["Thats it, you're now ready to do your part, I'm sure that with your help... hrm...",
				"civilization will be back to normal in no time",
				"Don't forget, your life is precious for us, so do your best to survive",
				"Good luck"],
				"event":"on_end"
			}}

# sets the phase to be "phase_id"
func set_phase(phase_id):
	current_phase = phase_id
	current_dialogue = phases[current_phase]["dialogue"]
	current_dialogue_index = 0
	_update_dialogue_label()

func _update_dialogue_label():
	dialogue_label.text = get_current_dialogue_line()

func get_current_dialogue_line():
	return current_dialogue[current_dialogue_index]

# called to show the next line, if we are on the last line, call the event
# of the phase
func progress_dialogue():
	if current_dialogue_index < current_dialogue.size() - 1:
		# increase index to the next line;
		current_dialogue_index += 1
		
		# update the dialogue gui
		_update_dialogue_label()
	elif current_dialogue_index == current_dialogue.size() - 1:
		# on the last line, call the event of the phase
		var event_name = phases[current_phase]["event"]
		if has_method(event_name):
			call(event_name)


func _input(event):
	pass
#	if !input_cooldown && event is InputEventMouseButton && event.button_index==BUTTON_LEFT:
#		progress_dialogue()
#		input_timer.start()
#		input_cooldown = true

func on_input_timer_cooldown():
	input_cooldown = false

func on_dialogue_button_pressed():
	progress_dialogue()

func deploy_stars_particles(pos):
	explosive_star_particles.global_position = pos
	explosive_star_particles.restart()

func on_tutorial_schnoop_pressed(enemy_id):
	var e = enemies_data.get_enemy_by_id(enemy_id)
	hud.call_battle(e)
	set_phase("solve_puzzle")

func on_battle_over(c, t):
	if c:
		# remove dead enemies:
		tutorial_schnoop.on_death()
		yield(tutorial_schnoop, "death_animation_over")
		deploy_stars_particles(tutorial_schnoop.global_position)
		tutorial_schnoop.queue_free()
		set_phase("prologue2")
	if !c:
		# if the question is incorrect set all the objects as unfired
		tutorial_schnoop.fired = false
		set_phase("enemy_missed")

func on_inventory_opened():
	if current_phase == "open_inventory":
		set_phase("sell")



# event functions:
# after the prologue text, an enemy should appear:
func on_prologue():
	combat_anim.play("open_simulation")
	yield(combat_anim, "animation_finished")
	combat_anim.play("enter_schnoop")
	set_phase("hit_enemy")

func on_hit_enemy():
	pass

# when the player sold an item
func on_sell():
	set_phase("end")
	pass

func on_prologue2():
	set_phase("open_inventory")

func on_end():
	transition.fade_to_main_menu()

func on_exit_button_pressed():
	transition.fade_to_main_menu()
