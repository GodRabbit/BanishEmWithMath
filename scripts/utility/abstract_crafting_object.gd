extends Node

# copyright 2021,2022 Dor "GodRabbit" Shlush
# this file is part of "BanishEmWithMath"

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

class_name abstract_crafting_object

# an abstract class that holds the data of a crafting object. 

# how many times the player can use this object before it need to refresh
var max_uses = 4
var current_uses = 0

# how many in-game days it take for this object to refresh
var cooldown = 1

var puzzle : puzzle_abstract

var object_id 
var object_name

var result_item : item_stack

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
