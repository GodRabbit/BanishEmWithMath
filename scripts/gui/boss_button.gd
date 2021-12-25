extends MarginContainer

# copyright 2021 Dor "GodRabbit" Shlush
# this file is part of "BanishEmWithMath"

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

# a gui class. for the player to enter a boss fight. The boss button will become
#  avaliable (hidden/?) when the player has the amount of stars to fight.
#  NOTE: the stars are not reducted from the player!

export var boss_id = "galactic_cake"

var boss_dic = {}
var stars_price = 1

# nodes:
onready var main_button = $main_container/main_button
onready var price_label = $main_container/stars_container/price_label


# Called when the node enters the scene tree for the first time.
func _ready():
	player_data.connect("stars_changed", self, "on_player_stars_changed")
	main_button.connect("pressed", self, "on_main_button_pressed")
	set_boss_id(boss_id)
	update_gui()

func set_boss_id(id):
	boss_id = id
	boss_dic = enemies_data.get_boss_by_id(id)
	stars_price = enemies_data.get_boss_star_price(player_data.get_current_zone(), boss_id)
	update_gui()

func update_gui():
	main_button.text = boss_dic["name"]
	price_label.text = str(stars_price)
	
	if player_data.get_current_stars() >= stars_price:
		main_button.disabled = false
	else:
		main_button.disabled = true

func on_main_button_pressed():
	transition.fade_to_boss_fight(boss_id)

func on_player_stars_changed(v):
	update_gui()
