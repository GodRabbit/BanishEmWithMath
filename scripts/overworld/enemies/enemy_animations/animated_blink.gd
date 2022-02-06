extends animated_enemy_sprite


# copyright 2021,2022 Dor "GodRabbit" Shlush
# this file is part of "BanishEmWithMath"

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

# an animation the 'blinks' through textures at timed intervals
# can be used for animals blinking or changing textures statically

export(Array, Texture) var textures
export(Array, float) var blink_times
export var random_times = false
export(Array, float) var random_times_range = [0.8, 1.2]

var index_textures = 0
var index_times = 0

# nodes:
onready var enemy_sprite = $enemy_sprite
onready var blink_timer = $blink_timer

# Called when the node enters the scene tree for the first time.
func _ready():
	blink_timer.connect("timeout", self, "on_blink_timer_timeout")
	
	_setup()

func _setup():
	# setup sprite:
	enemy_sprite.texture = textures[0]
	
	# setup timer:
	if !random_times:
		blink_timer.wait_time = blink_times[0]
	else:
		var t = rand_range(random_times_range[0], random_times_range[1])
		blink_timer.wait_time = t
	
	blink_timer.start()

func on_blink_timer_timeout():
	# update sprite:
	index_textures = (index_textures + 1) % textures.size()
	enemy_sprite.texture = textures[index_textures]
	
	# update timer:
	if !random_times:
		blink_timer.wait_time = blink_times[index_times]
		index_times = (index_times + 1) % blink_times.size()
	else: # choose a random wait time
		var t = rand_range(random_times_range[0], random_times_range[1])
		blink_timer.wait_time = t
	blink_timer.start()
