extends dynamic_background


# copyright 2021,2022 Dor "GodRabbit" Shlush
# this file is part of "BanishEmWithMath"

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

# nodes:
onready var boss_schnoop = $boss_ancient_rage_schnoop
onready var anim = $anim
onready var anim_color = $anim_colors

func call_schnoop_disappear():
	boss_schnoop.anim_body.play("death")

func on_death():
	# animations:
	boss_schnoop.start_death_idle()
	anim_color.play("death_idle")
	anim.play("death")
	yield(anim, "animation_finished")
	.on_death()

func on_spawn_enemies():
	boss_schnoop.start_spawn_anim()
	yield(boss_schnoop,"spawn_anim_finished")
	anim.play("spawn")
	.on_spawn_enemies()
