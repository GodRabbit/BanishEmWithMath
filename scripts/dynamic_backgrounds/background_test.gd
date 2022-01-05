extends "res://scripts/dynamic_backgrounds/abstract_dynamic_background.gd"


# copyright 2021,2022 Dor "GodRabbit" Shlush
# this file is part of "BanishEmWithMath"

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func on_spawn_enemies():
	print("debug test called <on_spawn_enemies>")
	$anim.play("move")
	yield($anim, "animation_finished")
	.on_spawn_enemies()
	print("super <on_spawn_enemies> called")
