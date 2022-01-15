extends TextureRect

# copyright 2021,2022 Dor "GodRabbit" Shlush
# this file is part of "BanishEmWithMath"

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

# a scene for a single hp heart

# nodes:
onready var heart_particles = $heart_particles
onready var hardcore_particles = $hardcore_particles

const TEXTURE_FULL = preload("res://images/gui/heart_full.png")
const TEXTURE_EMPTY = preload("res://images/gui/heart_empty.png")
const TEXTURE_FULL_ALTERNATE = preload("res://images/gui/skull_full.png")
const TEXTURE_EMPTY_ALTERNATE = preload("res://images/gui/skull_empty.png")


# whether this heart is filled or not.
export var filled = true

# is this the last heart the player has?
export var last_heart = false

# is this an alternate hp bar where instead of hearts we have skulls?
export var alternate = false

# Called when the node enters the scene tree for the first time.
func _ready():
	update_gui()

# true = filled
# false = empty
func set_state(_filled : bool):
	filled = _filled
	update_gui()

func set_alternate(val : bool):
	alternate = val
	update_gui()

func is_filled():
	return filled

func set_last_heart(val):
	last_heart = val
	update_gui()

func update_gui():
	if !alternate:
		if filled:
			texture = TEXTURE_FULL
			heart_particles.emitting = true
			
			if last_heart:
				hardcore_particles.emitting = true
			else:
				hardcore_particles.emitting = false
		else:
			heart_particles.emitting = false
			texture = TEXTURE_EMPTY
			hardcore_particles.emitting = false
	else:
		heart_particles.emitting = false
		if filled:
			texture = TEXTURE_FULL_ALTERNATE
			
			if last_heart:
				hardcore_particles.emitting = true
			else:
				hardcore_particles.emitting = false
		else:
			texture = TEXTURE_EMPTY_ALTERNATE
			hardcore_particles.emitting = false
