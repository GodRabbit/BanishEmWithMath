extends dynamic_background

# copyright 2021 Dor "GodRabbit" Shlush
# this file is part of "BanishEmWithMath"

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.


# dynamic background for the stage, the home of the feared "Sleeping Count".

# consts:
const START_POS = Vector2(504, 208)
const END_POS = Vector2(504, 416)

# the reveal hasn't happened yet
var is_revealed = false

# nodes:
onready var boss_sleeping_count = $boss_sleeping_count

# Called when the node enters the scene tree for the first time.
func _ready():
	# boss_sleeping_count.global_position = START_POS
	pass

# changes the position of the sleeping count.
# linear interpolation between Start_pos and End_pos.
func _change_pos(s):
	var m = 0.01*(END_POS - START_POS)
	boss_sleeping_count.global_position = START_POS + m*s

# called when the boss hp changed to "hp". hp is a number between 0.0 and 100.0
func on_boss_health_changed(hp):
	print("on boss hp changed sleeping count hp is "+str(hp))
	var inv = 100.0 - hp
	if inv < 50.0:
		_change_pos(inv*2.0)
		boss_sleeping_count.change_scale(inv*2)
	else:
		if !is_revealed:
			is_revealed = true
			boss_sleeping_count.reveal()

func on_spawn_enemies():
	boss_sleeping_count.start_spawn_animation()
	yield(boss_sleeping_count, "spawn_animation_finished")
	.on_spawn_enemies()

func on_death():
	.on_death()
