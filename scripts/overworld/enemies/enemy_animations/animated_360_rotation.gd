extends animated_enemy_sprite


# copyright 2021,2022 Dor "GodRabbit" Shlush
# this file is part of "BanishEmWithMath"

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

export var speed_scale = 1.0
export(Texture) var rotated_texture
export(Texture) var static_texture

# nodes:
onready var anim = $anim
onready var rotated_sprite = $rotated_sprite
onready var static_sprite = $static_sprite

# Called when the node enters the scene tree for the first time.
func _ready():
	anim.playback_speed = speed_scale
	update_sprite()
	play_idle()

# overriden from parent
func update_sprite():
	if rotated_texture != null:
		rotated_sprite.texture = rotated_texture
	else:
		var e_texture = load(IMAGE_PATH % enemy_id)
		rotated_sprite.texture = e_texture
	
	if static_texture != null:
		static_sprite.texture = static_texture

func play_idle():
	anim.play("idle")
	anim.seek(rand_range(0, 2))

func stop_animation():
	anim.stop(false)
