extends animated_enemy_sprite

# copyright 2021,2022 Dor "GodRabbit" Shlush
# this file is part of "BanishEmWithMath"

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

# an animation the 'blinks' through textures at timed intervals
# can be used for animals blinking or changing textures statically

export var speed_scale = 1.0
export(Texture) var texture 

# nodes:
onready var enemy_sprite = $enemy_sprite
onready var anim = $anim

# Called when the node enters the scene tree for the first time.
func _ready():
	anim.playback_speed = speed_scale
	update_sprite()
	play_idle()

# overriden from parent. 
func update_sprite():
	if texture != null:
		enemy_sprite.texture = texture
	else:
		var e_texture = load(IMAGE_PATH % enemy_id)
		enemy_sprite.texture = e_texture

func play_idle():
	$anim.play("idle")
	$anim.seek(rand_range(0, 2))

func stop_animation():
	$anim.stop(false)
