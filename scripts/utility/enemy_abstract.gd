extends Reference

# copyright 2021,2022 Dor "GodRabbit" Shlush
# this file is part of "BanishEmWithMath"

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

# an abstract class that represnts the enemy

class_name enemy_abstract

var puzzle : puzzle_abstract

var time = 30
var damage = 1
var stars = 3
var items = {}

var enemy_id = "_empty_"
var enemy_name = "_empty_"

func _init(_id, _name, _puzzle, _time = 60, _stars = 3,_dmg = 1, _items = {}):
	enemy_id = _id
	enemy_name = _name
	puzzle = _puzzle
	time = _time
	stars = _stars
	damage = _dmg
	items = _items.duplicate()

func get_enemy_id():
	return enemy_id

func get_enemy_name():
	return enemy_name 

func get_puzzle():
	return puzzle

func get_time():
	return time

func get_stars():
	return stars

func get_damage():
	return damage

func get_items():
	return items
