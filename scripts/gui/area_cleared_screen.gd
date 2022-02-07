extends MarginContainer


# copyright 2021,2022 Dor "GodRabbit" Shlush
# this file is part of "BanishEmWithMath"

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

# a gui node for showing an indication that the area cleared.
# [its not part of the hud, but part of the combat scene (to prevent clugging the hud too much)]

# nodes:
onready var continue_button = $main_container/button_container/continue_button
onready var wait_here_button = $main_container/button_container/wait_here_button
onready var star_particles_right = $star_particles_right
onready var star_particles_left = $star_particles_left

# val = true: they player wants to leave
# val = false: the player wants to stay
signal exit_request(val)

# Called when the node enters the scene tree for the first time.
func _ready():
	wait_here_button.connect("pressed", self, "on_wait_here_button_pressed")
	continue_button.connect("pressed", self, "on_continue_button_pressed")

func hide():
	emit_particles(false)
	.hide()

func show():
	emit_particles(true)
	.show()

func emit_particles(val : bool):
	star_particles_left.emitting = val
	star_particles_right.emitting = val

func on_wait_here_button_pressed():
	emit_signal("exit_request", false)

func on_continue_button_pressed():
	emit_signal("exit_request", true)
