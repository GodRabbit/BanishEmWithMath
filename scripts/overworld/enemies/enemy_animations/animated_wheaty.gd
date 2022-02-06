extends animated_enemy_sprite

# copyright 2021,2022 Dor "GodRabbit" Shlush
# this file is part of "BanishEmWithMath"

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

# nodes:
onready var anim_hands = $anim_hands
onready var anim_leaf = $anim_leaf
onready var anim_body = $anim_body

# Called when the node enters the scene tree for the first time.
func _ready():
	play_idle()


func play_idle():
	anim_hands.play("idle")
	anim_hands.seek(rand_range(0, 2))
	
	anim_leaf.play("idle")
	anim_leaf.seek(rand_range(0, 2))
	
	anim_body.play("idle")
	anim_body.seek(rand_range(0, 2))

func stop_animation():
	anim_hands.stop(false)
	anim_leaf.stop(false)
	anim_body.stop(false)
