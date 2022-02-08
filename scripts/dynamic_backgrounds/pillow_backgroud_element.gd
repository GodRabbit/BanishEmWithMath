extends Node2D

# copyright 2021,2022 Dor "GodRabbit" Shlush
# this file is part of "BanishEmWithMath"

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

# a pillow background element for the Sleeping Count boss fight background.
# has a random size, three kinds of color

const COLOR_DARK = Color("#9d7c9a")
const COLOR_MIDDLE = Color("#cdabca")
const COLOR_NEUTRAL = Color("#ffffff")
const MIN_SCALE = 0.7
const MAX_SCALE = 1.0
const MIN_SPEED = 1.0
const MAX_SPEED = 1.5

enum COLORS_MODUL {NEUTRAL, MIDDLE, DARK}

export(COLORS_MODUL) var color_type

# nodes:
onready var anim_movement = $sprite/anim_movement
onready var anim_shader = $sprite/anim_shader
onready var sprite = $sprite

# Called when the node enters the scene tree for the first time.
func _ready():
	update_element()
	play_idle()

func _get_color_by_value(v):
	match v:
		COLORS_MODUL.NEUTRAL:
			return COLOR_NEUTRAL
		COLORS_MODUL.MIDDLE:
			return COLOR_MIDDLE
		COLORS_MODUL.DARK:
			return COLOR_DARK

func update_element():
	# set color:
	sprite.modulate = _get_color_by_value(color_type)
	
	# set size:
	randomize()
	var _scale = rand_range(MIN_SCALE, MAX_SCALE)
	sprite.scale = _scale * scale
	
	# set flip:
	var num = randi() % 2
	if num == 0:
		sprite.flip_h = true
	else:
		sprite.flip_h = false
	
	# set speed:
	var _speed = rand_range(MIN_SPEED, MAX_SPEED)
	anim_movement.playback_speed = _speed
	
	var _speed2 = rand_range(MIN_SPEED, MAX_SPEED)
	anim_shader.playback_speed = _speed2

func play_joy():
	anim_movement.play("stop")
	anim_shader.play("joy")
	yield(anim_movement,"animation_finished")
	anim_movement.play("joy")
	yield(anim_movement,"animation_finished")
	play_idle()

func play_idle():
	anim_movement.play("idle0")
	randomize()
	var _speed = rand_range(MIN_SPEED, MAX_SPEED)
	anim_movement.playback_speed = _speed

func play_death():
	anim_movement.play("stop")
	anim_shader.play("death")
