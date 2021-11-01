extends "res://scripts/overworld/object_area.gd"


# copyright 2021 Dor "GodRabbit" Shlush
# this file is part of "BanishEmWithMath"

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.


# Called when the node enters the scene tree for the first time.
func _ready():
	$anim.play("spawn")


func on_spawn():
	pass
