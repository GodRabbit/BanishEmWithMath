extends dynamic_background

# copyright 2021,2022 Dor "GodRabbit" Shlush
# this file is part of "BanishEmWithMath"

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.


# dynamic background for the stage, the home of the feared "Sleeping Count".

# consts:
const START_POS = Vector2(1008, 375.746)
const END_POS = Vector2(1008, 832)

# the reveal hasn't happened yet
var is_revealed = false

# death flag to prevent animation race condition between death & spawn enemies
var is_dead = false

# nodes:
onready var boss_sleeping_count = $boss_sleeping_count
onready var anim = $anim

var pillows = []

# Called when the node enters the scene tree for the first time.
func _ready():
	set_pillows()

# changes the position of the sleeping count.
# linear interpolation between Start_pos and End_pos.
func _change_pos(s):
	var m = 0.01*(END_POS - START_POS)
	boss_sleeping_count.global_position = START_POS + m*s

# called when the boss hp changed to "hp". hp is a number between 0.0 and 100.0
func on_boss_health_changed(hp):
	Log.log_print("on boss hp changed sleeping count hp is "+ str(hp))
	if hp == 0.0:
		is_dead = true
	var inv = 100.0 - hp
	if inv < 50.0:
		_change_pos(inv*2.0)
		boss_sleeping_count.change_scale(inv*2)
	else:
		if !is_revealed:
			is_revealed = true
			boss_sleeping_count.reveal()

func on_spawn_enemies():
	if is_dead:
		return
	boss_sleeping_count.start_spawn_animation()
	#anim.play("spawn") # not good enough
	pillows_play_joy()
	yield(boss_sleeping_count, "spawn_animation_finished")
	#anim.play("idle")
	.on_spawn_enemies()

func on_death():
	Log.log_print("sleeping count was sent a death request;")
	is_dead = true
	pillows_play_death()
	boss_sleeping_count.play_death()
	anim.play("death")
	yield(anim, "animation_finished")
	.on_death()
	#Log.log_print("Sleeping count 'on_death' was emitted!")

# adds all the pillows to an array to mass control them
func set_pillows():
	pillows = []
	var path = "background/row%d_%s/pillow_backgroud_element%d"
	
	# i loops through rows
	for i in range(1, 4):
		# j loops through pillows
		for j in range(1, 6):
			var pillow1 = get_node(path % [i, "right", j])
			var pillow2 = get_node(path % [i, "left", j])
			pillows.append(pillow1)
			pillows.append(pillow2)

func pillows_play_joy():
	for p in pillows:
		p.play_joy()

func pillows_play_death():
	for p in pillows:
		p.play_death()
