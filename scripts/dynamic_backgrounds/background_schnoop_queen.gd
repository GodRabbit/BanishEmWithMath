extends dynamic_background

# copyright 2021,2022 Dor "GodRabbit" Shlush
# this file is part of "BanishEmWithMath"

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

# nodes:
onready var boss_schnoop_queen = $boss_schnoop_queen
onready var anim = $anim
onready var hearts_particles = $hearts_particles

# Called when the node enters the scene tree for the first time.
func _ready():
	hearts_particles.emitting = false
	final_boss = true


func on_spawn_enemies():
	boss_schnoop_queen.start_spawn_anim()
	yield(boss_schnoop_queen,"spawn_anim_finished")
	anim.play("shockwave")
	.on_spawn_enemies()

func on_death():
	# since this is the last boss of the zone: call timer to pause before animations:
	player_data.pause_timer()
	
	# animations:
	boss_schnoop_queen.start_death_idle()
	anim.play("death")
	yield(anim, "animation_finished")
	.on_death()

func on_boss_health_changed(hp):
	Log.log_print("schnoop queen changed hp")

func call_schnoop_queen_disappear():
	boss_schnoop_queen.anim_body.play("death")
