extends Node2D

# copyright 2021,2022 Dor "GodRabbit" Shlush
# this file is part of "BanishEmWithMath"

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

# a class for a portal effect that shows behind enemies.

signal portal_opened
signal portal_closed

# Called when the node enters the scene tree for the first time.
func _ready():
	portal_open()


func portal_open():
	$anim.play("portal_open")
	yield($anim, "animation_finished")
	emit_signal("portal_opened")
	$anim.play("portal_idle1")

func portal_close():
	$anim.play("portal_close")
	emit_signal("portal_closed")
