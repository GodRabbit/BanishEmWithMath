extends animated_enemy_sprite

# copyright 2021,2022 Dor "GodRabbit" Shlush
# this file is part of "BanishEmWithMath"

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

# a class for rotation animation of an enemy sprite

export var speed_scale = 0.3
export var random_start = true

# nodes:
onready var enemy_sprite = $enemy_sprite
onready var anim = $anim

func _ready():
	anim.playback_speed = speed_scale
	update_sprite()
	play_idle()

# overriden from parent. 
func update_sprite():
	var texture = load(IMAGE_PATH % enemy_id)
	enemy_sprite.texture = texture

func play_idle():
	$anim.play("idle")
	$anim.seek(rand_range(0, 2))

func stop_animation():
	$anim.stop(false)
