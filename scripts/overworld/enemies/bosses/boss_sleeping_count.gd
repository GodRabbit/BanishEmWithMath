extends Node2D

# copyright 2021,2022 Dor "GodRabbit" Shlush
# this file is part of "BanishEmWithMath"

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

# a class for animating the boss "sleeping_count"

# consts:
const SPRITE_PATH = "res://images/enemies/sleeping_count/%s.png"
const MIN_SCALE = 0.333
const MAX_SCALE = 0.666

# nodes:
onready var body = $body
onready var explosive_hearts_particles = $explosive_hearts_particles

# signals:
signal spawn_animation_finished

# Called when the node enters the scene tree for the first time.
func _ready():
	body.texture = load(SPRITE_PATH % "sleeping_count_pre")
	change_scale(0)

func reveal():
	body.texture = load(SPRITE_PATH % "sleeping_count_post")

# change the scale of this boss by s, s is a number between 0 to 100
#  and deform according to min and max scale
#  is used with the boss hp function to scale this boss
func change_scale(s):
	# linear scale, (0.0, Min_scale) -> (100.0, Max_scale)
	var m = (MAX_SCALE - MIN_SCALE)/100.0
	body.scale = Vector2(MIN_SCALE + m*s, MIN_SCALE + m*s)

func deploy_hearts_particles():
	explosive_hearts_particles.restart()

func start_spawn_animation():
	$anim.play("blink")
	yield($anim, "animation_finished")
	emit_signal("spawn_animation_finished")

func play_death():
	body.texture = load(SPRITE_PATH % "sleeping_count_pre")
	$anim.play("death")
