extends animated_enemy_sprite


# copyright 2021,2022 Dor "GodRabbit" Shlush
# this file is part of "BanishEmWithMath"

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

# nodes:
onready var anim_wings = $anim_wings
onready var anim_body = $anim_body

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	anim_wings.playback_speed = rand_range(0.7, 1.0)
	anim_body.playback_speed = rand_range(0.7, 1.0)
	play_idle()

func play_idle():
	anim_wings.play("idle")
	anim_wings.seek(rand_range(0, 2))
	
	anim_body.play("idle")
	anim_body.seek(rand_range(0, 2))

func stop_animation():
	anim_wings.stop(false)
	anim_body.stop(false)

