extends CanvasLayer

# copyright 2021,2022 Dor "GodRabbit" Shlush
# this file is part of "BanishEmWithMath"

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

var path

func _ready():
	pass

#func fade_to_main_manu():
#	path = "res://scenes/gui/main_manu.tscn"
#	$anim.play("fade_to")
#
#func fade_to_game():
#	path = "res://scenes/main_scene.tscn"
#	$anim.play("fade_to")
#
#func fade_to_tutorial():
#	path = "res://scenes/gui/tutorial.tscn"
#	$anim.play("fade_to")

func fade_to_overworld():
	path = "res://scenes/overworld/overworld.tscn"
	$anim.play("fade_to")

# needs to add some variables to combat though
func fade_to_combat(site_id):
	path = "res://scenes/overworld/combat.tscn"
	player_data.set_current_site(site_id)
	$anim.play("fade_to")

func fade_to_main_menu():
	path = "res://scenes/gui/main_menu.tscn"
	$anim.play("fade_to")

func fade_to_boss_fight(boss_id):
	path = "res://scenes/overworld/boss_combat.tscn"
	player_data.set_current_boss(boss_id)
	$anim.play("fade_to")

# private function called from within the animation
func _change_scene():
	if(path != ""):
		get_tree().change_scene(path)
		get_tree().set_pause(false)

func fade_to_tutorial():
	path = "res://scenes/tutorial/tutorial_scene.tscn"
	$anim.play("fade_to")
