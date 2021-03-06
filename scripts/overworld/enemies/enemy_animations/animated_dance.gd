extends animated_enemy_sprite


# copyright 2021,2022 Dor "GodRabbit" Shlush
# this file is part of "BanishEmWithMath"

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

export var speed_scale = 1.0
export var texture : Texture

# nodes:
onready var enemy_sprite = $enemy_sprite
onready var anim = $anim


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	anim.playback_speed = rand_range(speed_scale*0.9, speed_scale*1.1)


func play_idle():
	anim.play("idle")
	anim.seek(rand_range(0, 4.5))

func stop_animation():
	anim.stop(false)

