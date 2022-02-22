extends Node2D

# copyright 2021,2022 Dor "GodRabbit" Shlush
# this file is part of "BanishEmWithMath"

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

# a scene to represnt the boss of The Darkened City

onready var anim_body = $anim_body
onready var anim_wings = $anim_wings

signal spawn_anim_finished

func start_spawn_anim():
	anim_wings.play("primed")
	yield(anim_wings,"animation_finished")
	anim_body.play("primed")
	yield(anim_body, "animation_finished")
	emit_signal("spawn_anim_finished")
	anim_wings.play_backwards("primed")
	yield(anim_wings,"animation_finished")
	anim_body.play("idle")
	anim_wings.play("idle")

func start_death_idle():
	anim_body.play("death_idle")
	anim_wings.play("death_idle")
