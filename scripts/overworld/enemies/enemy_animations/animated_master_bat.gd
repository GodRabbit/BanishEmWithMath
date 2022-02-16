extends animated_enemy_sprite


# copyright 2021,2022 Dor "GodRabbit" Shlush
# this file is part of "BanishEmWithMath"

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

# nodes:
onready var anim = $anim

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	anim.playback_speed = rand_range(0.8, 1.0)


func play_idle():
	anim.play("idle")
	anim.seek(rand_range(0, 3))

func stop_animation():
	anim.stop(false)
