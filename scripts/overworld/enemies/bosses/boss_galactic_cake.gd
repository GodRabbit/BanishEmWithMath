extends Node2D

# copyright 2021 Dor "GodRabbit" Shlush
# this file is part of "BanishEmWithMath"

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

# a class incharge of animating and moving the boss "galctic_cake"

# nodes:
onready var blink_timer = $body/eyes/blink_timer
onready var eye_anim = $body/eyes/eye_anim
onready var anim = $anim
onready var explosive_particles = $explosive_star_particles
onready var death_particles = $explosive_death_particles


# Called when the node enters the scene tree for the first time.
func _ready():
	blink_timer.connect("timeout", self, "on_blink_timer_timeout")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func on_blink_timer_timeout():
	eye_anim.play("blink")
	blink_timer.wait_time = rand_range(1.2, 3.0)
	blink_timer.start()

func deploy_explosive_particles():
	explosive_particles.restart()

func deploy_death_particles():
	death_particles.restart()
