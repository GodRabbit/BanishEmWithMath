extends animated_enemy_sprite


# copyright 2021,2022 Dor "GodRabbit" Shlush
# this file is part of "BanishEmWithMath"

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

const SCHNOOP_IMAGE_PATH = "res://images/enemies/schnoops/%s_%s.png"

#export var scale_factor = 1.0
export var schnoop_id = "baby_schnoop"
export var speed_scaling = 1.0
export var random_speed = false
export var random_speed_range = [0.85, 1.0]

# nodes:
onready var body_sprite = $body
onready var wing_left_sprite = $body/wing_left
onready var wing_right_sprite = $body/wing_right
onready var anim = $anim

# Called when the node enters the scene tree for the first time.
func _ready():
	update_sprite()
	play_idle()

# overriden from parent
func update_sprite():
	var wing_texture = load(SCHNOOP_IMAGE_PATH % [schnoop_id, "wing"])
	body_sprite.texture = load(SCHNOOP_IMAGE_PATH % [schnoop_id, "body"])
	wing_left_sprite.texture = wing_texture
	wing_right_sprite.texture = wing_texture

func play_idle():
	randomize()
	anim.play("idle")
	anim.seek(rand_range(0, 2))
	if random_speed:
		var m = min(random_speed_range[0], random_speed_range[1])
		var M = max(random_speed_range[0], random_speed_range[1])
		anim.playback_speed = rand_range(m, M)
	else:
		anim.playback_speed = speed_scaling


func stop_animation():
	anim.stop(false)
