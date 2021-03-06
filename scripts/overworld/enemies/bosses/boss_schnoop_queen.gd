extends Node2D

# copyright 2021,2022 Dor "GodRabbit" Shlush
# this file is part of "BanishEmWithMath"

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

# a class resposnsible for animating the boss schnoop queen

# nodes:
onready var anim_body = $anim_body
onready var anim_hands = $anim_hands

signal spawn_anim_finished

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func start_spawn_anim():
	anim_hands.play("hands_primed")
	yield(anim_hands,"animation_finished")
	anim_body.play("primed")
	yield(anim_body, "animation_finished")
	emit_signal("spawn_anim_finished")
	anim_hands.play_backwards("hands_primed")
	yield(anim_hands,"animation_finished")
	anim_body.play("idle")
	anim_hands.play("idle")

func start_death_idle():
	anim_body.play("death_idle")
	anim_hands.play("idle")
