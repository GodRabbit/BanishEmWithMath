extends Node2D

# copyright 2021,2022 Dor "GodRabbit" Shlush
# this file is part of "BanishEmWithMath"

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

# an abstract scene that represents the background on boss fights.
# the center piece is the boss, that appear and spawns minions
# and then die when the fight ends.

# IMPORTANT NOTE: You must implement all the animation for spawn and death
# to let processes in the background finish. More than 1 sec of animation 
#  should be enough. Bug reason is still unknown.

class_name dynamic_background


# a signal that the background must emit, that its ready to spawn
# enemies (usually after on_spawn_enemies is over)
signal ready_to_spawn

# a signal that emits when all the death animations are over
# this tells the boss_combat that you can move to the next scene.
signal ready_to_die

# DERPRECATED?
# a signal the boss emits when the spawning animation is over and the waves can begin.
signal ready_to_begin

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

# DEPRECATED?
# the background is idle. nothing unique happens; what plays between 
# unique animations.
func idle():
	pass

# the background is doing an animation before spawning enemies.
# at the end of the function call ready_to_spawn
#  #NOTE: allways do an animation before calling the super method
#    Why? i don't know. I guess you need to wait?!
func on_spawn_enemies():
	emit_signal("ready_to_spawn")

func on_death():
	Log.log_print("abstract dynamic background was sent a death request")
	emit_signal("ready_to_die")
	

# deprecated?
func on_enter():
	emit_signal("ready_to_spawn")

# called when the boss hp changed to "hp". hp is a number between 0.0 and 100.0
func on_boss_health_changed(hp):
	pass
