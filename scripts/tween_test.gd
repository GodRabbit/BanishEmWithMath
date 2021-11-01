extends Node2D

# copyright 2021 Dor "GodRabbit" Shlush
# this file is part of "BanishEmWithMath"

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.


# Called when the node enters the scene tree for the first time.
func _ready():
	var tween = $Tween
	tween.interpolate_property($Sprite, "scale", Vector2(1.0, 1.0), Vector2(0, 0), 1, 
	Tween.TRANS_LINEAR)
	tween.set_active(true)
	tween.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
