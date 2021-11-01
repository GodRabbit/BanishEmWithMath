extends Area2D

# copyright 2021 Dor "GodRabbit" Shlush
# this file is part of "BanishEmWithMath"

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

class_name object_area
# similar to crafting area, just for distructable objects.
# when the player clicks on the area, the object will emit a signal and then
# be destroyed.
# (will be handled by the world to call crafting window)

export var enemy_id = "none"

# a signal to be emitted when the player presses the object
# r is a recipe_id associated with this object.
signal object_pressed(r)
signal death_animation_over

# a boolean; is the object fired or not yet? Fired objects are objects the 
# player pressed on them and are waiting deletion
var fired = false

# whether the enemy is paused
var paused = false

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("object_areas")

# no signal. just checks for mouse clicks.
# NOTE: all mouse clicks will trigger this. not just the left!
# fix this sometime. maybe.
func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton && event.is_pressed() && !fired:
		# check if the player can intercat with enemies or on cooldown:
		# this mechanic is to prevent 2 enemies be pressed at the same time
		if player_data.can_interact_with_enemies() and !paused:
			# the player is now on cooldown:
			player_data.start_pressing_cooldown()
			
			# emit signals:
			emit_signal("object_pressed",enemy_id)
			
			# mark the object for deletion
			fired = true

func is_fired():
	return fired

func set_pause(val):
	paused = val

# abstract method to be overided by the enemy
func on_spawn():
	print("on spawn test")

# play death animation and set the object for firing.
# this method can be overided by the enemy
func on_death():
	if fired:
		# create a portal behind this enemy 
		var portal = load("res://scenes/sfx/portal_effect.tscn").instance()
		add_child(portal)
		portal.show_behind_parent = true
		yield(portal, "portal_opened")
		# tween scale to 0
		var tween = Tween.new()
		self.add_child(tween) # this have to be added for the twin to work!
		tween.interpolate_property(self, "scale", Vector2(1.0, 1.0), Vector2(0, 0), 1, 
		Tween.TRANS_CUBIC)
		tween.set_active(true)
		tween.start()
		var star_particles = load("res://scenes/sfx/explosive_star_particles.tscn").instance()
		add_child(star_particles)
		star_particles.restart()
		yield(tween, "tween_all_completed")


		emit_signal("death_animation_over")
