extends Node2D

# copyright 2021,2022 Dor "GodRabbit" Shlush
# this file is part of "BanishEmWithMath"

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.


# a gui scene. A button for the player to purchase a site AND go to it once it 
# bought.

export var site_id = "farm"

const SITE_ICON_PATH = "res://images/gui/background_icons/%s_icon.png"
const RIBBON_IMAGE_PATH = "res://images/gui/background_icons/ribbon_%s.png"

# nodes:
onready var purchase_button = $main_container/purchase_container/purchase_button
onready var main_button = $main_button
onready var ribbon_button = $ribbon_button
onready var site_name_label = $ribbon_button/site_name_label
onready var purchase_label = $main_container/purchase_container/purchase_label
onready var purchase_container = $main_container/purchase_container
onready var addition_purchase_container = $main_container/additional_purchase_container
onready var anim = $anim

# Called when the node enters the scene tree for the first time.
func _ready():
	purchase_button.connect("pressed", self, "on_purchase_button_pressed")
	main_button.connect("pressed", self, "on_main_button_pressed")
	update_gui()

func set_site_id(id):
	site_id = id
	update_gui()

func update_gui():
	ribbon_button.texture_normal = load(RIBBON_IMAGE_PATH % site_id)
	main_button.texture_normal = load(SITE_ICON_PATH % site_id)
	
	if is_unlocked():
		# if the site is unlocked the purchase button is useless
		purchase_container.hide()
		addition_purchase_container.hide()
		main_button.disabled = false
		ribbon_button.disabled = false
		anim.play("unlocked")
	else:
		# not unlocked yet, so you can't use the main button to go to the site
		anim.play("locked")
		main_button.disabled = true
		ribbon_button.disabled = true
		purchase_container.show()
		addition_purchase_container.show()
		
		var site_price = enemies_data.get_site_price(player_data.get_current_zone(), site_id, player_data.get_new_game())
		# sets the purchase money button text:
		purchase_label.text = "%d" % site_price["money"]
		
		# set the item purchase text
		var site_keys = site_price.keys()
		
		for c in addition_purchase_container.get_children():
			addition_purchase_container.remove_child(c)
			c.queue_free()
		
		# loop through the item ids in <site_keys> and asdd them:
		for k in site_keys: 
			# k is item_id or money
			if k != "money":
				var item_displayer = load("res://scenes/gui/item_displayer_vertical.tscn").instance()
				addition_purchase_container.add_child(item_displayer)
				item_displayer.set_item(item_stack.new(k, site_price[k]))
				

# checks if this site was unlocked by the player
func is_unlocked():
	return player_data.check_site(site_id)

func on_purchase_button_pressed():
	player_data.purchase_site(site_id)
	purchase_container.hide() # to prevent multiple pressing of the purchase button
	if is_unlocked():
		anim.play("unlocking")
		yield(anim, "animation_finished")
	update_gui()

func on_main_button_pressed():
	# the timer start if it hasn't started yet
	if !player_data.is_timer_activated(): 
		player_data.start_timer()
	transition.fade_to_combat(site_id)
