extends Node2D

# copyright 2021,2022 Dor "GodRabbit" Shlush
# this file is part of "BanishEmWithMath"

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

class_name animated_enemy_sprite

# an abstract class for animating an enemy sprite

const IMAGE_PATH = "res://images/enemies/%s.png"

export var enemy_id = "" setget set_enemy_id, get_enemy_id

func _ready():
	pass

func set_enemy_id(id):
	enemy_id = id

func get_enemy_id():
	return enemy_id

func play_idle():
	pass

func stop_animation():
	pass

func update_sprite():
	pass
